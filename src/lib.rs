#![feature(associated_type_defaults)]
#![feature(unboxed_closures)]
#![feature(path_file_prefix)]
#![feature(path_try_exists)]
#![feature(seek_stream_len)]
#![feature(thread_id_value)]
#![feature(fs_try_exists)]

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
mod tests;
mod tests_util;
mod util;
use crate::data_file::{load_data_files, DataFile};
use crate::entry::{Entry, CRC32};
use crate::error::BitCaskError::{EmptyKey, TooLargeKey, TooLargeValue, UnexpectedError};
use crate::error::Result;
use crate::hint::Hint;
use crate::metadata::MetaData;
use crate::radix_tree::{Index, Indexer, Persisted};
use crate::recover::check_and_recover;
use crate::util::{expire_hint, expire_key, load_index_from_data_file};
pub use config::Config;
use crossbeam::sync::WaitGroup;
use crossbeam_channel::{select, Receiver, Sender};
use fslock::LockFile;
use kv_log_macro::{debug, error, info};
use std::borrow::Borrow;
use std::cell::RefCell;
use std::collections::HashMap;
use std::fmt::Debug;
use std::fs;
use std::fs::{remove_file, rename, File, OpenOptions};
use std::ops::Sub;
use std::path::Path;
use std::sync::atomic::{AtomicBool, Ordering};
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
fn merge_ticker(bitcask: BitCask, rx: Receiver<()>, cfg: Config) {
    let tid = std::thread::current().id().as_u64();
    loop {
        let interval = crossbeam_channel::after(Duration::from_secs(cfg.auto_merge_interval_check));
        select! {
            recv(interval) -> msg => {
                info!("receive a merge ticker");
            },
            recv(rx) -> ch => {
                 info!(
                    "receive a exit signer, exited merge at backend, tid: {}",
                    tid
                );
                return;
            }
        }
        let mut execute_merge = false;
        let metadata = bitcask.lc().metadata.clone();
        if cfg.auto_merge_dirty_used > 0 && metadata.dirty_space > cfg.auto_merge_dirty_used {
            execute_merge = true;
        }
        if cfg.auto_merge_dirty_used_rate > 0.0
            && metadata.total_space_used > 0
            && cfg.auto_merge_dirty_used_rate
                < (metadata.dirty_space as f64 / metadata.total_space_used as f64)
        {
            execute_merge = true;
        }
        if !execute_merge {
            info!("skip merge, tid: {}", tid);
            continue;
        }
        info!("start to merge at backend, tid: {}", tid);
        if let Err(err) = bitcask.merge() {
            error!("failed to merge at backend, tid: {}, err: {}", tid, err);
        } else {
            info!("end to merge at backend, tid: {}", tid);
        }
    }
    info!("finish call Once, tid: {}", tid);
}

impl BitCask {
    pub fn open(path: &Path, cfg: impl Into<Option<Config>>) -> Result<Self> {
        let cfg = cfg.into();
        let bc = BitCaskCore::open(path, cfg.clone())?;
        let (tx, rx) = crossbeam_channel::bounded::<()>(0);
        let bitcask = BitCask {
            inner: Arc::new(Mutex::new(bc)),
            tx: Some(tx),
        };
        let _bitcask = bitcask.clone();
        if cfg.is_some() && cfg.as_ref().unwrap().auto_merge {
            info!("auto merge at backend");
            spawn(move || {
                merge_ticker(_bitcask, rx, cfg.unwrap());
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
            info!("wait merge job exit");
            tx.send(());
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
        bc.put(key.clone(), vec![], None)?;
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

    pub fn scan(
        &self,
        prefix: impl Into<Option<Vec<u8>>>,
        mut f: impl FnMut((&[u8], &[u8])) -> Result<()>,
    ) -> Result<()> {
        let prefix = prefix.into().unwrap_or_default();
        let mut bc = self.lc();
        for (key, hint) in bc.hint_index.iter_prefix(&prefix).into_iter() {
            if let Some(ref value) = bc.get(key) {
                if let Err(err) = f((key, value)) {
                    return Err(err);
                }
            }
        }
        Ok(())
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
    pid_lock: LockFile,
}

impl BitCaskCore {
    fn open(path: &Path, cfg: impl Into<Option<Config>>) -> Result<Self> {
        let path = vec![path.to_str().unwrap(), "bitcask"].join("/");
        match fs::create_dir_all(path.clone()) {
            Ok(_) => {}
            Err(err) if err.kind() == ::std::io::ErrorKind::AlreadyExists => {}
            Err(err) => return Err(UnexpectedError(err.to_string())),
        }
        let mut pid_lock = LockFile::open(&Path::new(&path).join("lock"))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        pid_lock
            .lock()
            .map_err(|err| UnexpectedError(err.to_string()))?;
        info!("ready to open a new db connection");

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
        let mut bc = BitCaskCore::new(path, index, None, meta, cfg, pid_lock);
        bc.reopen()?;
        Ok(bc)
    }

    fn new(
        base_dir: String,
        hint: Indexer<Hint>,
        wt_data_file: Option<DataFile>,
        meta: MetaData,
        cfg: Config,
        lock: LockFile,
    ) -> Self {
        BitCaskCore {
            hint_index: hint,
            curr: wt_data_file,
            datafiles: Default::default(),
            config: cfg,
            path: base_dir,
            metadata: meta,
            pid_lock: lock,
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

    fn delete_all(&mut self) -> Result<()> {
        let curr_file = { self.curr.take().unwrap().path_name() };
        remove_file(&curr_file)?;
        info!("remove current file: {}", curr_file);
        let data_files = self
            .datafiles
            .values()
            .map(|df| df.path_name())
            .collect::<Vec<_>>();
        {
            self.datafiles.clear();
        }
        for data_file in data_files {
            remove_file(&data_file).map_err(|err| UnexpectedError(err.to_string()))?;
            info!("remove data_file: {}", data_file);
        }
        {
            self.hint_index.clear();
            let hint_file = Path::new(self.path.as_str()).join(Hint::HINT_FILE);
            remove_file(&hint_file)?;
            info!("remove hint file: {}", hint_file.to_string_lossy());
        }
        {
            self.metadata.index_up_to_date = true;
            self.metadata.total_space_used = 0;
            self.metadata.dirty_space = 0;
            let meta_file = Path::new(self.path.as_str()).join(MetaData::NAME);
            remove_file(&meta_file).unwrap();
            info!("remove metadata file: {}", meta_file.to_string_lossy());
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
        let expire_fn = expire_hint();
        // load hint files
        let found = self.hint_index.load(
            Path::new(self.path.as_str())
                .join(Hint::HINT_FILE)
                .to_string_lossy()
                .as_ref(),
            Some(expire_fn),
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
        self.metadata.index_up_to_date = true;
        if let Err(err) = self.save_indexes() {
            error!("failed to save indexes, err: {}", err);
        }
        if let Err(err) = self.pid_lock.unlock() {
            error!("failed to unlock pid lock, err: {}", err);
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
            if entry.expiry > 0 && entry.expiry < chrono::Utc::now().timestamp() {
                dirty += 1;
                debug!("skip1 the expired key at merge, key: {:?}, old-file_id: {}, old-offset: {}, file_id:{}, offset: {}", &hex_key, oldest, offset, last_file_id, last_offset);
                // remove it from hint_file
                let exits = self.hint_index.remove(&key);
                assert!(exits.is_some(), "it should not happen");
                self.metadata.total_space_used -= entry.size() as u64;
                continue;
            }
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
