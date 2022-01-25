#![feature(associated_type_defaults)]
#![feature(unboxed_closures)]
#![feature(path_file_prefix)]
#![feature(path_try_exists)]
#![feature(seek_stream_len)]
#![feature(thread_id_value)]

mod codec;
mod config;
mod data_file;
mod entry;
mod error;
mod hint;
mod key_value;
mod metadata;
mod radix_tree;
mod recover;
mod tests_util;
mod util;
use std::ops::Sub;

use crate::config::Config;
use crate::data_file::{load_data_files, DataFile};
use crate::entry::{Entry, CRC32};
use crate::error::BitCaskError::{EmptyKey, TooLargeKey, TooLargeValue, UnexpectedError};
use crate::error::Result;
use crate::hint::Hint;
use crate::metadata::MetaData;
use crate::radix_tree::{Index, Indexer, Persisted};
use crate::recover::check_and_recover;
use crate::util::load_index_from_data_file;
use kv_log_macro::{debug, error, info};
use std::borrow::Borrow;
use std::cell::RefCell;
use std::collections::HashMap;
use std::fmt::Debug;
use std::fs;
use std::fs::{remove_file, rename, File, OpenOptions};
use std::path::Path;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::mpsc::{channel, sync_channel, Receiver, Sender, TryRecvError};
use std::sync::{Arc, Mutex, MutexGuard, Once};
use std::thread::{sleep, spawn, JoinHandle};
use std::time::{Duration, Instant};

#[derive(Clone)]
pub struct BitCask {
    inner: Arc<Mutex<BitCaskCore>>,
    tx: Option<Sender<()>>,
}

trait MergeProcessor {
    fn process(&mut self) -> Result<()>;
}

// TODO optimize auto merge
fn merge_ticker(bitcask: BitCask, rx: Receiver<()>) {
    let tid = std::thread::current().id().as_u64();
    loop {
        let ok = rx.try_recv();
        if ok.is_ok() {
            info!(
                "receive a exit signer, exited merge at backend, tid: {}",
                tid
            );
            return;
        }
        if ok.is_err() {
            if ok.unwrap_err() == TryRecvError::Disconnected {
                info!(
                    "receive a exit signer, exited merge at backend, tid: {}",
                    tid
                );
                return;
            }
            continue;
        }
        info!("start to merge at backend, tid: {}", tid);
        if let Err(err) = bitcask.merge() {
            error!("failed to merge at backend, tid: {}, err: {}", tid, err);
        } else {
            info!("end to merge at backend, tid: {}", tid);
        }
        sleep(Duration::from_secs(10));
    }
    info!("finish call Once, tid: {}", tid);
}

impl BitCask {
    pub fn open(path: &Path, cfg: impl Into<Option<Config>>) -> Result<Self> {
        let cfg = cfg.into();
        let bc = BitCaskCore::open(path, cfg.clone())?;
        let (tx, rx) = channel();
        let bitcask = BitCask {
            inner: Arc::new(Mutex::new(bc)),
            tx: Some(tx),
        };
        let _bitcask = bitcask.clone();
        if cfg.is_some() && cfg.unwrap().auto_merge {
            info!("auto merge at backend");
            spawn(move || {
                merge_ticker(_bitcask, rx);
            });
        }
        info!(
            "welcome to use bitcask: {}",
            path.join("bitcask").to_string_lossy()
        );
        Ok(bitcask)
    }

    // don't forgive to invoke `close` if auto merge
    pub fn close(&self) -> Result<()> {
        if let Some(ref tx) = self.tx {
            while tx.send(()).is_ok() {
                sleep(Duration::from_secs(1));
                info!(
                    "wait merge job closed, tid: {}",
                    std::thread::current().id().as_u64()
                );
            }
            info!("exited succeed");
        }
        Ok(())
    }

    pub fn put(&self, key: Vec<u8>, value: Vec<u8>) -> Result<()> {
        self.put_with_ttl(key, value, 0)
    }

    pub fn put_with_ttl(&self, key: Vec<u8>, value: Vec<u8>, mut ttl: i64) -> Result<()> {
        if key.is_empty() {
            return Err(EmptyKey);
        }
        let mut bc = self.lc();
        if ttl > 0 {
            ttl = chrono::Utc::now().timestamp() + ttl;
        }
        let hint = bc.put(key.clone(), value, ttl)?;
        bc.metadata.index_up_to_date = false;
        if bc.hint_index.get(&key).is_some() {
            // every put yields space
            bc.metadata.reclaimable_space += hint.size;
        }
        bc.hint_index.insert(key, hint);
        Ok(())
    }

    pub fn get(&self, key: &Vec<u8>) -> Option<Vec<u8>> {
        let bc = self.lc();
        bc.get(key)
    }

    pub fn all_data(&self) -> Vec<(Vec<u8>, Vec<u8>)> {
        let bc = self.lc();
        bc.entries()
            .into_iter()
            .map(|entry| (entry.key, entry.value))
            .collect::<Vec<_>>()
    }

    pub fn merge(&self) -> Result<()> {
        let mut bc = self.lc();
        bc.merge()
    }

    pub fn delete(&self, key: &Vec<u8>) -> Result<()> {
        let mut bc = self.lc();
        if let Some((file_id, sz)) = bc.hint_index.get(key).map(|hint| (hint.file_id, hint.size)) {
            bc.metadata.reclaimable_space += sz;
        }
        bc.hint_index.remove(key);
        Ok(())
    }

    pub fn delete_all(&self) -> Result<()> {
        let mut bc = self.lc();
        bc.delete_all()
    }

    pub fn exists(&self, key: &Vec<u8>) -> bool {
        let bc = self.lc();
        if let Some(index) = bc.hint_index.get(key) {
            return !bc.expired(key);
        }
        return false;
    }

    pub fn count(&self) -> usize {
        let bc = self.lc();
        bc.hint_index.count()
    }

    fn reopen(&mut self) -> Result<()> {
        let mut bc = self.lc();
        bc.reopen()
    }

    fn lc(&self) -> MutexGuard<'_, BitCaskCore> {
        self.inner.lock().unwrap()
    }
}

struct BitCaskCore {
    hint_index: Indexer<Hint>,
    curr: Option<DataFile>,
    datafiles: HashMap<u64, DataFile>,
    config: Config,
    path: String,
    metadata: MetaData,
}

impl BitCaskCore {
    fn open(path: &Path, cfg: impl Into<Option<Config>>) -> Result<Self> {
        let path = vec![path.to_str().unwrap(), "bitcask"].join("/");
        match fs::create_dir_all(path.clone()) {
            Ok(_) => {}
            Err(err) if err.kind() == ::std::io::ErrorKind::AlreadyExists => {}
            Err(err) => return Err(UnexpectedError(err.to_string())),
        }
        let mut cfg = cfg.into();
        if cfg.is_none() {
            let ok = fs::try_exists(Path::new(path.as_str()).join("config.toml"))
                .map_err(|err| UnexpectedError(err.to_string()))?;
            if ok {
                cfg = Some(Config::load(Path::new(path.as_str()).join("config.toml"))?);
            } else {
                cfg = Some(Config::default());
            }
        }
        let cfg = cfg.unwrap();
        cfg.save(Path::new(path.as_str()).join("config.toml"))?;
        let meta = MetaData::load_and_create(&path)?;
        let index = Indexer::new();

        if cfg.auto_recovery {
            check_and_recover(path.as_str(), &cfg)?;
            debug!("succeed to auto recover");
        }

        let mut bc = BitCaskCore::new(path, index, None, meta, cfg);
        bc.reopen()?;
        Ok(bc)
    }

    pub fn new(
        base_dir: String,
        hint: Indexer<Hint>,
        wt_data_file: Option<DataFile>,
        meta: MetaData,
        cfg: Config,
    ) -> Self {
        BitCaskCore {
            hint_index: hint,
            curr: wt_data_file,
            datafiles: Default::default(),
            config: cfg,
            path: base_dir,
            metadata: meta,
        }
    }

    fn get(&self, key: &Vec<u8>) -> Option<Vec<u8>> {
        let check_sum_at_get_key = self.config.check_sum_at_get_key;
        let hint = {
            let index = self.hint_index.get(key);
            if index.is_none() {
                return None;
            }
            let index = index.unwrap();
            if index.is_expire() {
                return None;
            }
            index
        };

        let data_file = {
            if let Some(curr) = self.curr.as_ref() {
                if curr.id == hint.file_id {
                    curr
                } else {
                    self.datafiles.get(&hint.file_id).unwrap()
                }
            } else {
                self.datafiles.get(&hint.file_id).unwrap()
            }
        };
        let entry = data_file
            .read_at(*hint.offset.borrow(), hint.size as usize)
            .unwrap();
        if check_sum_at_get_key && entry.check_sum != CRC32.checksum(&*entry.value) {
            error!(
                "file_id: {}, key: {:?}, failed to checksum",
                data_file.id,
                entry.key_to_string(),
            );
            panic!();
        }
        Some(entry.value)
    }

    fn get_by_file_id(&mut self, file_id: u64, offset: u64, sz: u64) -> Result<Entry> {
        let df = if file_id == self.curr.as_ref().unwrap().file_id() {
            self.curr.as_mut().unwrap()
        } else {
            self.datafiles.get_mut(&file_id).unwrap()
        };
        df.read_at(offset, sz as usize)
    }

    fn put(
        &mut self,
        key: Vec<u8>,
        value: Vec<u8>,
        expiry: impl Into<Option<i64>>,
    ) -> Result<Hint> {
        let expiry = expiry.into().unwrap_or_else(|| 0);
        if self.config.max_key_size > 0 && self.config.max_key_size < key.len() as u32 {
            return Err(TooLargeKey);
        }
        if self.config.max_value_size > 0 && self.config.max_value_size < value.len() as u64 {
            return Err(TooLargeValue);
        }
        let mut entry_sz = 0;
        {
            self.maybe_rotate()?;
            let cur = self.curr.as_mut().unwrap();
            let entry = Entry::new(key.clone(), value.clone(), expiry);
            cur.write(&entry)?;
            entry_sz = entry.size();
        }
        if self.config.sync {
            self.curr.as_mut().unwrap().sync()?;
        }
        // in case of successful `put`, index_up_to_date will be always be false.
        self.metadata.index_up_to_date = false;
        let last_file_id = self.curr.as_ref().unwrap().file_id();
        let last_file_offset = self.curr.as_ref().unwrap().file_offset()?;
        let hint = Hint::new(
            last_file_id,
            last_file_offset - entry_sz as u64,
            entry_sz as u64,
            expiry,
        );
        self.metadata.total_space_used += entry_sz as u64;
        if value.is_empty() {
            self.metadata.dirty_space += entry_sz as u64;
        }
        Ok(hint)
    }

    // TODO maybe very heap
    fn delete_all(&mut self) -> Result<()> {
        self.hint_index.clear();
        let curr_file = { self.curr.take().unwrap().path_name() };
        remove_file(curr_file)?;
        let data_files = self
            .datafiles
            .values()
            .map(|df| df.path_name())
            .collect::<Vec<_>>();
        {
            self.datafiles.clear();
        }
        for data_file in data_files {
            remove_file(data_file).map_err(|err| UnexpectedError(err.to_string()))?;
        }
        {
            self.metadata.index_up_to_date = true;
            self.metadata.reclaimable_space = 0;
        }
        self.reopen()
    }

    fn merge(&mut self) -> Result<()> {
        self.process()
    }

    fn expired(&self, key: &Vec<u8>) -> bool {
        if let Some(entry) = self.hint_index.get(key) {
            return entry.expiry() > 0 && entry.expiry() <= chrono::Utc::now().timestamp();
        }
        return false;
    }

    fn maybe_rotate(&mut self) -> Result<()> {
        // close the file descriptors
        let curr = self.curr.take();
        let mut curr = curr.unwrap();
        if curr.size() < self.config.max_data_file_size {
            self.curr = Some(curr);
            return Ok(());
        }
        let id = curr.file_id();
        curr.move_to_read()?;
        debug!("move to read {}", curr.path_name());
        self.datafiles.insert(id, curr);
        // create a new only write datafile
        {
            let new_data_file = DataFile::new(id + 1, self.path.as_str().to_string(), false);
            debug!("create a new data file: {}", new_data_file.path_name());
            self.curr = Some(new_data_file);
        }

        // save indexes
        {
            self.save_indexes()?;
        }
        debug!("the last write file: {}", self.curr.as_ref().unwrap().id);
        Ok(())
    }

    fn save_indexes(&mut self) -> Result<()> {
        let tmp = Path::new(self.path.as_str()).join("tmp_hint_index");
        self.hint_index.save(tmp.to_str().unwrap())?;
        rename(tmp, Path::new(self.path.as_str()).join(Hint::HINT_FILE))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        debug!("succeed to save hint file");
        self.metadata.index_up_to_date = true;
        self.metadata.save(&self.path)?;
        Ok(())
    }

    // reloads a bitcask object with index and datafiles caller of this method should take care of locking
    fn reopen(&mut self) -> Result<()> {
        // 1: load data files
        let (last_file_id, mut data_files) = load_data_files(&self.path, self.config.clone())?;
        // 2: load hint file
        self.load_hints(&mut data_files, last_file_id)?;
        self.curr = Some(DataFile::new(last_file_id, self.path.clone(), false));
        self.datafiles = data_files;
        debug!("reopen bitcask, the last file id is {}", last_file_id);
        Ok(())
    }

    fn load_hints(
        &mut self,
        data_files: &mut HashMap<u64, DataFile>,
        last_file_id: u64,
    ) -> Result<()> {
        // load hint files
        let found = self.hint_index.load(
            Path::new(self.path.as_str())
                .join(Hint::HINT_FILE)
                .to_string_lossy()
                .as_ref(),
            None::<fn(&Hint) -> bool>,
        )?;
        debug!("succeed to load hint, found: {}", found);
        // TODO: index_up_to_date: Why?
        if found && self.metadata.index_up_to_date {
            debug!("found the hint index and it is up to date");
            return Ok(());
        }
        // maybe value had expired
        if found {
            debug!("found the hint index, but it is not up to date");
            let mut last_data_file = data_files.get_mut(&last_file_id).unwrap();
            return load_index_from_data_file(&mut self.hint_index, &mut last_data_file);
        }

        // maybe index is not available, eg: last bitcask process crashed and had removed at recover
        {
            let mut v = data_files
                .iter_mut()
                .map(|(key, value)| (key, value))
                .collect::<Vec<_>>();
            v.sort_by(|(a, _), (b, _)| a.cmp(b));
            for (_, mut data_file) in v {
                load_index_from_data_file(&mut self.hint_index, &mut data_file)?;
            }
        }
        Ok(())
    }

    pub(crate) fn entries(&self) -> Vec<Entry> {
        let cur_file_id = self.curr.as_ref().unwrap().file_id();
        let key_values = self
            .hint_index
            .iter()
            .map(|(key, value)| (key.clone(), value.clone()))
            .collect::<Vec<_>>();
        let mut entries = vec![];
        for (key, hint) in key_values {
            let fs = {
                if cur_file_id == hint.file_id {
                    self.curr.as_ref().unwrap()
                } else {
                    self.datafiles.get(&hint.file_id).unwrap()
                }
            };
            assert!(hint.size <= 1 << 10);
            let entry = fs.read_at(hint.offset, hint.size as usize).unwrap();
            entries.push(entry);
        }
        entries
    }
}

impl Drop for BitCaskCore {
    fn drop(&mut self) {
        if let Err(err) = self.save_indexes() {
            error!("failed to save indexes, err: {}", err);
        }
        self.metadata.index_up_to_date = true;
        if let Err(err) = self.metadata.save(&self.path) {
            error!("failed to save metadata: err: {}", err);
        }
        debug!("bitcask core had drop");
    }
}

impl MergeProcessor for BitCaskCore {
    fn process(&mut self) -> Result<()> {
        info!("start to merge process");
        // 1: Find the oldest file key
        let mut keys = self
            .datafiles
            .keys()
            .map(|key| key.clone())
            .collect::<Vec<_>>();
        if keys.len() <= 1 {
            info!("not found more than one file to be merged");
            return Ok(());
        }
        keys.sort();
        let oldest = keys.first().unwrap();
        let df = self.datafiles.get_mut(oldest).unwrap();
        df.reset()?;
        let keys = df
            .into_iter()
            .filter(|(_, entry)| !entry.value.is_empty())
            .map(|(offset, entry)| (offset, entry.key))
            .collect::<Vec<_>>();
        let mut total = 0;
        let mut dirty = 0;
        let start = chrono::Utc::now();
        for (offset, key) in keys {
            debug!("merge key: {}", String::from_utf8_lossy(&key));
            total += 1;
            let hex_key = String::from_utf8(key.clone()).unwrap();
            let last_entry = self.hint_index.get(&key);
            if last_entry.is_none() {
                dirty += 1;
                debug!(
                    "skip the key at merge because it had deleted, key: {:?}",
                    &hex_key
                );
                continue;
            }
            let (last_file_id, last_offset, sz) = last_entry
                .map(|hint| (hint.file_id, hint.offset, hint.size))
                .unwrap();
            assert!(
                oldest <= &last_file_id,
                "it should be not happen, merged_file_id({}) must lte last_file({})",
                oldest,
                last_file_id
            );
            if oldest < &last_file_id {
                dirty += 1;
                debug!("skip1 the key at merge, key: {:?}, old-file_id: {}, old-offset: {}, file_id:{}, offset: {}", &hex_key, oldest, offset, last_file_id, last_offset);
                continue;
            }
            assert_eq!(*oldest, last_file_id);
            assert!(
                offset <= last_offset,
                "offset: {} should be lte {}",
                offset,
                last_offset
            );
            if offset < last_offset {
                debug!("skip1 the key at merge, key: {:?}, old-file_id: {}, old-offset: {}, file_id:{}, offset: {}", &hex_key, oldest, offset, last_file_id, last_offset);
                dirty += 1;
                continue;
            }
            assert_eq!(offset, last_offset);

            // Find it and reput it
            let entry = self.get_by_file_id(last_file_id, last_offset, sz)?;
            assert_eq!(&key, &entry.key);
            assert!(!entry.value.is_empty());
            let hint = self.put(key.clone(), entry.value.clone(), entry.expiry)?;
            self.hint_index.insert(key.clone(), hint.clone());
            assert_eq!(hint.size, sz);
            debug!("reput the key: {:?}, old-file_id: {}, old-offset: {}, file_id:{}, offset: {}, size: {}, expiry: {}",&hex_key, oldest, offset, last_file_id, last_offset, sz, entry.expiry);
        }
        // delete the merge file
        {
            let path_name = self.datafiles.remove(oldest).unwrap().path_name();
            remove_file(&path_name).map_err(|err| UnexpectedError(err.to_string()))?;
            debug!("remove the merged file: {}", path_name);
        }
        // save indexs
        {
            self.save_indexes()?;
        }
        info!(
            "merge stats, {:0>10}.data, total: {}, dirty: {}, cost: {}ms",
            oldest,
            total,
            dirty,
            chrono::Utc::now().sub(start).num_milliseconds()
        );
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use crate::{BitCask, Config, DataFile, Entry, Hint, Index, Indexer, Persisted};
    use env_logger::{Env, Target};
    use log::{debug, info, log_enabled};
    use rand::random;
    use std::collections::HashMap;
    use std::fs::{remove_dir_all, OpenOptions};
    use std::io::Cursor;
    use std::path::Path;
    use std::str::Chars;
    use std::sync::atomic::{AtomicBool, Ordering};
    use std::sync::mpsc::channel;
    use std::thread::{sleep, spawn};
    use std::time::{Duration, Instant};
    use tempdir::TempDir;

    #[test]
    fn bitcask() {
        let tmp = mock(None);
        let cfg = Config::default();
        let bitcask = BitCask::open(Path::new(&tmp), Some(cfg));
        assert!(bitcask.is_ok());
    }

    #[test]
    fn put() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(Path::new(&tmp), Some(cfg)).unwrap();
        for i in 1..=10000 {
            let ok = bitcask
                .put(format!("{}", i).into_bytes(), Vec::from(r#"bar"#))
                .is_ok();
            assert!(ok);
        }
        assert_eq!(bitcask.count(), 10000);
    }

    #[test]
    fn put_ttl() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
        for i in 1..=10000 {
            bitcask
                .put_with_ttl(format!("{}", i).into_bytes(), Vec::from(r#"bar"#), 60)
                .unwrap();
        }
        assert_eq!(bitcask.count(), 10000);
    }

    #[test]
    fn get_and_delete() {
        let n = 10000;
        let bitcask = generate_n(n, 10);
        for i in 1..n {
            let value = bitcask.get(&format!("{}", i).into_bytes());
            assert!(value.is_some());
        }
        for i in 1..n {
            let ok = bitcask.delete(&format!("{}", i).into_bytes());
            assert!(ok.is_ok());
        }
        for i in 1..n {
            let value = bitcask.get(&format!("{}", i).into_bytes());
            assert!(value.is_none());
        }
    }

    #[test]
    fn delete_all() {
        let n = 3;
        let bitcask = generate_n(n, 3);
        for i in 1..n {
            let value = bitcask.get(&format!("{}", i).into_bytes());
            assert!(value.is_some());
        }
        let ok = bitcask.delete_all();
        assert!(ok.is_ok());
        (1..n).into_iter().for_each(|i| {
            let value = bitcask.get(&format!("{}", i).into_bytes());
            assert!(value.is_none());
        });
        // reopen
        for i in 1..n {
            let mut value = vec![];
            value.extend(::std::iter::repeat(0).take(1 << 10));
            bitcask
                .put_with_ttl(format!("{}", i).into_bytes(), value, 60)
                .unwrap();
        }
        for i in 1..n {
            let value = bitcask.get(&format!("{}", i).into_bytes());
            assert!(value.is_some());
        }
    }

    #[test]
    fn exists() {
        let mut bitcask = generate_n(10000, 3);
        let exists = bitcask.exists(&format!("{}", 1).into_bytes());
        assert_eq!(exists, true);
        let exists = bitcask.exists(&format!("{}", 100001).into_bytes());
        assert_eq!(exists, false);
        sleep(Duration::from_secs(4));
        let exist = bitcask.exists(&format!("{}", 1).into_bytes());
        assert_eq!(exist, false);
    }

    #[test]
    fn rate() {
        use std::time::{Duration, Instant};
        let tmp = mock(None);
        let mut cfg = Config::default().auto_sync(false);
        let mut bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
        let timestamp = Instant::now();
        let n = 100000;
        for i in 1..=n {
            let mut value = Vec::from(r#"bar"#);
            value.extend(::std::iter::repeat(0).take(1 << 10));
            bitcask
                .put_with_ttl(format!("{}", i).into_bytes(), value, 60)
                .unwrap();
        }
        debug!(
            "cost time: {} million, count: {}, dir: {}",
            timestamp.elapsed().as_millis(),
            n,
            tmp
        );
    }

    #[test]
    fn recover() {
        let tmp = mock(None);
        let mut n = 1000;
        {
            let mut cfg = Config::default().auto_sync(false).auto_merge(true);
            let mut bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
            for i in 1..=n {
                let key = format!("{:0>10}", i).into_bytes();
                let mut value = generate_n_sz_buffer(1 << 10);
                bitcask.put_with_ttl(key, value, 60).unwrap();
            }
            assert_eq!(bitcask.count(), n);
            assert!(bitcask.close().is_ok());
        }

        // recover
        {
            let mut cfg = Config::default().auto_sync(false).auto_merge(true);
            let mut bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
            assert_eq!(bitcask.count(), n);
            assert!(bitcask.close().is_ok());
        }
        // delete it
        let mut hint1 = HashMap::new();
        {
            let cfg = Config::default().auto_sync(false).auto_merge(true);
            let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
            for i in 1..=n {
                let del_key = random::<usize>() % n;
                let del_key = format!("{:0>10}", del_key).into_bytes();
                bitcask.delete(&del_key);
                debug!("delete key: {}", String::from_utf8_lossy(&del_key));
            }
            let ok = bitcask.count() < n;
            n = bitcask.count();
            assert!(ok);
            hint1 = bitcask
                .lc()
                .hint_index
                .iter()
                .map(|(key, value)| (key.clone(), value.clone()))
                .collect::<HashMap<_, _>>();
            assert!(bitcask.close().is_ok());
        }
        // recover again
        let mut hint2 = HashMap::new();
        {
            let mut cfg = Config::default().auto_sync(false).auto_merge(true);
            let mut bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
            let count = bitcask.count();
            hint2 = bitcask
                .lc()
                .hint_index
                .iter()
                .map(|(key, value)| (key.clone(), value.clone()))
                .collect::<HashMap<_, _>>();
            // assert_eq!(hint1.len(), hint2.len());
            for (key, value) in hint2 {
                let ok = hint1.get(&key).is_some();
                if !ok {
                    println!("diff, {}", String::from_utf8_lossy(&key));
                }
            }
            assert_eq!(count, n);
            assert!(bitcask.close().is_ok());
        }
    }

    #[test]
    fn merge1() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        {
            let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
            // batch write entries
            // [1, 1024] [1025, 2048], [2049, 4096]
            let entries = generate_1m_entry();
            let entries = entries[0..4096].to_vec();
            for entry in &entries {
                bitcask.put_with_ttl(entry.key.clone(), entry.value.clone(), entry.expiry);
            }
            for i in 1..=1 {
                bitcask.merge();
            }
            let mut final_entries = bitcask.lc().entries();
            final_entries.sort_by(|a, b| a.key.cmp(b.key.as_ref()));
            assert_eq!(entries.len(), final_entries.len());
            for i in 0..entries.len() {
                assert_eq!(format!("{}", entries[i]), format!("{}", final_entries[i]));
            }
        }
    }

    #[test]
    fn merge_with_delete() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
        let entries = generate_1m_entry();
        let num = entries.len();

        for entry in &entries {
            bitcask.put_with_ttl(entry.key.clone(), entry.value.clone(), entry.expiry);
        }

        for i in 0..num {
            let key = random::<usize>() % num;
            let key = format!("{:0>10}", key).into_bytes();
            bitcask.delete(&key);
        }
        bitcask.merge().unwrap();
    }

    #[test]
    fn merge_auto() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
        let entries = generate_1m_entry();
        let num = entries.len();

        for entry in &entries {
            bitcask.put_with_ttl(entry.key.clone(), entry.value.clone(), entry.expiry);
        }
        sleep(Duration::from_secs(5));
        bitcask.close();
    }

    #[test]
    fn generate_data() {
        mock(None);
        generate_1m_entry();
    }

    #[test]
    fn merge_random() {
        let tmp = mock(None);
        remove_dir_all(Path::new(&tmp));
        let cfg = Config::default()
            .auto_sync(false)
            .set_check_sum_at_get_key(true);
        let bitcask = BitCask::open(Path::new(&tmp), cfg.clone()).unwrap();
        let entries = generate_1m_entry();
        let num = entries.len();
        for entry in &entries {
            let ok = bitcask.put_with_ttl(entry.key.clone(), entry.value.clone(), entry.expiry);
            assert!(ok.is_ok());
        }
        for i in 0..num {
            let key = random::<usize>() % num;
            let key = format!("{:0>10}", key).into_bytes();
            let ok = bitcask.delete(&key);
            assert!(ok.is_ok());
        }
        let final_entries = bitcask.lc().entries();
        for i in 0..20 {
            bitcask.merge().unwrap();
        }
        let after_entries = bitcask.lc().entries();
        assert_eq!(final_entries.len(), after_entries.len());
    }

    #[test]
    fn merge_recycle() {
        let tmp = mock(None);
        let cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(Path::new(&tmp), cfg).unwrap();
        let entries = generate_1m_entry();
        for entry in entries {
            bitcask
                .put_with_ttl(entry.key, entry.value, entry.expiry)
                .unwrap();
        }
        for i in 0..50 {
            bitcask.merge().unwrap();
        }
        let final_entries = bitcask.lc().entries();
    }

    fn mock(prefix: impl Into<Option<String>>) -> String {
        use log::LevelFilter;
        use std::io::Write;
        // let mut builder = env_logger::builder();
        // builder.is_test(true).format_module_path(true).format(|buf, record|
        //     writeln!(buf, "tid: {}, {}", std::thread::current().id().as_u64(), record.args())).parse_env(Env::new().default_filter_or("info"));
        env_logger::try_init_from_env(Env::new().default_filter_or("info"));
        let prefix = prefix.into();
        return if let Some(prefix) = prefix {
            prefix.to_owned()
        } else {
            String::from(
                tempdir::TempDir::new("bitcask")
                    .unwrap()
                    .path()
                    .to_string_lossy(),
            )
        };
    }

    fn generate_n(n: usize, ttl: i64) -> BitCask {
        let tmp = mock(None);
        let mut cfg = Config::default().auto_sync(false);
        let bitcask = BitCask::open(tmp.as_ref(), cfg).unwrap();
        for i in 1..n {
            let mut value = vec![];
            value.extend(::std::iter::repeat(0).take(1 << 10));
            bitcask
                .put_with_ttl(format!("{}", i).into_bytes(), value, ttl)
                .unwrap();
        }
        bitcask
    }

    // create 1m * 10 entries, every entry is 1kb
    fn generate_1m_entry() -> Vec<Entry> {
        use rand::{distributions::Alphanumeric, Rng};
        let mut entires = vec![];
        let start = chrono::Utc::now();
        let header_size = Entry::MATA_INFO_SIZE;
        let kv = (1 << 10) - header_size;
        let value = rand::thread_rng()
            .sample_iter(&Alphanumeric)
            .take(kv)
            .map(char::from)
            .collect::<String>()
            .into_bytes();
        for i in 1..=1024 * 10 {
            let key = format!("{:0>10}", i).into_bytes();
            let mut entry = Entry::new(vec![], vec![], 0);
            entry.value = value.clone()[..(kv - key.len())].to_vec();
            entry.key = key;
            entires.push(entry);
        }
        debug!(
            "generate data cost time: {} ms",
            chrono::Utc::now().timestamp_millis() - start.timestamp_millis()
        );
        entires
    }

    fn generate_n_sz_buffer(n: usize) -> Vec<u8> {
        use rand::{distributions::Alphanumeric, Rng};
        let value = rand::thread_rng()
            .sample_iter(&Alphanumeric)
            .take(n)
            .map(char::from)
            .collect::<String>()
            .into_bytes();
        value
    }
}
