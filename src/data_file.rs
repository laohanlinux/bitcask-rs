use crate::codec::{Decode, Encode};
use crate::config;
use crate::entry::Entry;
use crate::error::BitCaskError::{NoMoreData, UnexpectedError};
use crate::error::{BitCaskError, Result};
use crate::hint::Hint;
use crate::radix_tree::{Index, Indexer};
use crate::util::{get_data_files, parse_file_ids};
use filename::Filename;
use log::{debug, error, warn};
use std::borrow::{Borrow, BorrowMut};
use std::cell::RefCell;
use std::collections::HashMap;
use std::fs::{remove_file, rename, File, OpenOptions};
use std::io::SeekFrom::End;
use std::io::{Read, Seek, SeekFrom, Write};
use std::path::Path;
use std::sync::atomic::AtomicI64;

// TODO: add cache
#[derive(Default)]
pub(crate) struct DataFile {
    pub(crate) id: u64,
    pub(crate) fs: Option<File>,
    pub(crate) base_name: String,
    iter_offset: usize,
    pub(crate) _ref: AtomicI64,
}

impl DataFile {
    pub(crate) fn new(id: u64, base_name: String, only_read: bool) -> DataFile {
        let path = Path::new(base_name.as_str()).join(format!("{:0>10}.data", id));
        let fs = {
            if only_read {
                OpenOptions::new().read(true).open(path).unwrap()
            } else {
                OpenOptions::new()
                    .write(true)
                    .append(true)
                    .create(true)
                    .read(true)
                    .open(path)
                    .unwrap()
            }
        };
        DataFile {
            id,
            fs: Some(fs),
            base_name,
            iter_offset: 0,
            _ref: AtomicI64::new(0),
        }
    }

    pub(crate) fn incr_ref(&self) {
        self._ref.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
    }

    pub(crate) fn decr_ref(&self) {
        self._ref.fetch_sub(1, std::sync::atomic::Ordering::SeqCst);
    }

    pub(crate) fn file_id(&self) -> u64 {
        self.id
    }

    pub(crate) fn full_name(&self) -> String {
        format!("{:0>10}.data", self.id)
    }

    pub(crate) fn base_name(&self) -> String {
        self.base_name.clone()
    }

    pub(crate) fn path_name(&self) -> String {
        Path::new(self.base_name.as_str())
            .join(self.full_name())
            .to_string_lossy()
            .to_string()
    }

    pub(crate) fn sync(&mut self) -> Result<()> {
        let fs = self.fs.as_ref().unwrap();
        fs.sync_all().map_err(|err| err.into())
    }

    pub(crate) fn size(&self) -> u64 {
        let fs = self.fs.as_ref().unwrap();
        fs.metadata().unwrap().len()
    }

    pub(crate) fn file_offset(&self) -> Result<u64> {
        let mut fs = self.fs.as_ref().unwrap();
        fs.stream_len()
            .map_err(|err| UnexpectedError(err.to_string()))
    }

    pub(crate) fn move_to_read(&mut self) -> Result<()> {
        {
            self.fs.take();
        }
        let fs = OpenOptions::new()
            .read(true)
            .open(self.path_name())
            .map_err(|err| UnexpectedError(err.to_string()))?;
        self.fs = Some(fs);
        Ok(())
    }

    pub(crate) fn read(&self) -> Result<Entry> {
        let mut fs = self.fs.as_ref().unwrap();
        let entry = Entry::decode(&mut fs)?;
        Ok(entry)
    }

    pub(crate) fn read_at(&self, index: u64, rd_size: usize) -> Result<Entry> {
        let mut fs = self.fs.as_ref().unwrap();
        fs.seek(SeekFrom::Start(index))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let mut buf = vec![0; rd_size];
        fs.read(&mut buf)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        Ok(Entry::from(buf))
    }

    pub(crate) fn read_all(&mut self) -> Result<Vec<Entry>> {
        let mut set = vec![];
        self.reset()?;
        loop {
            match self.read() {
                Ok(entry) => {
                    debug!("trace batch read: {}", entry);
                    set.push(entry);
                }
                Err(ref err) if err.is_io_eof() => break,
                Err(err) => return Err(err),
            }
        }
        Ok(set)
    }

    // *Notice* only append
    pub(crate) fn write(&mut self, entry: &Entry) -> Result<()> {
        let fs = self.fs.as_mut().unwrap();
        fs.seek(SeekFrom::End(0))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let offset = fs.stream_len().unwrap();
        entry.encode(fs)?;
        Ok(())
    }

    pub(crate) fn reset(&mut self) -> Result<()> {
        let fs = self.fs.as_mut().unwrap();
        fs.seek(SeekFrom::Start(0))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        self.iter_offset = 0;
        Ok(())
    }
}

impl Iterator for DataFile {
    type Item = (u64, Entry);

    fn next(&mut self) -> Option<Self::Item> {
        match self.read() {
            Ok(entry) => {
                let entry_offset = self.iter_offset as u64;
                self.iter_offset += entry.size();
                Some((entry_offset, entry))
            }
            Err(ref err) if err.is_io_eof() => None,
            Err(err) => panic!("{:?}", err),
        }
    }
}

impl Drop for DataFile {
    fn drop(&mut self) {
        if let Some(fs) = self.fs.take() {
            if let Err(err) = fs.sync_all() {
                error!("failed to sync data file: {}", err);
            }
        }
    }
}

pub(crate) fn recover_last_data_file(path: &str, cfg: &config::Config) -> Result<bool> {
    let mut fs_rd = File::open(path).map_err(|err| UnexpectedError(err.to_string()))?;
    let p = Path::new(path);
    let file_name = p.file_name().unwrap().to_string_lossy().to_string();
    let recover_file_path = p.with_file_name(format!("{}.recover", file_name));
    let fs_wd = OpenOptions::new()
        .create(true)
        .write(true)
        .append(true)
        .open(recover_file_path.clone())
        .map_err(|err| UnexpectedError(err.to_string()))?;
    let mut corrupted = false;
    while corrupted {
        match Entry::decode(&mut fs_rd) {
            Ok(entry) => {}
            Err(err) if err.is_corrupted_data() => {
                // TODO it should be no happen
                warn!("{} is corrupted, a best-effort recovery was done", path);
                corrupted = true;
                continue;
            }
            Err(err) if err.is_io_eof() => break,
            Err(err) => return Err(err),
        }
    }
    fs_wd
        .sync_all()
        .map_err(|err| UnexpectedError(err.to_string()))?;
    drop(fs_wd);
    drop(fs_rd);
    if !corrupted {
        remove_file(&recover_file_path).map_err(|err| UnexpectedError(err.to_string()))?;
        debug!(
            "{} is not corrupted, remove recover: {}",
            path,
            recover_file_path.to_string_lossy()
        );
        return Ok(false);
    }

    // cover `path` file
    rename(&recover_file_path, path).map_err(|err| UnexpectedError(err.to_string()))?;
    debug!("cover file '{}' had renamed at recover", file_name);
    Ok(true)
}

// returns last_file_id and data files
pub(crate) fn load_data_files(
    p: &str,
    cfg: config::Config,
) -> Result<(u64, HashMap<u64, DataFile>)> {
    let mut data_files = get_data_files(p)?;
    let data_file_ids = parse_file_ids(&mut data_files)?;
    let data_files = data_file_ids
        .iter()
        .map(|file_id| (*file_id, DataFile::new(*file_id, p.to_string(), true)))
        .collect::<HashMap<u64, DataFile>>();
    let last_file_id = data_file_ids.last().unwrap_or_else(|| &0);
    debug!(
        "load data file succeed, last_file_id: {}, data files count: {}",
        last_file_id,
        data_files.len()
    );
    Ok((*last_file_id, data_files))
}

#[test]
fn data_file_write_and_read() {
    use serde_json::to_string;
    use tempdir::TempDir;
    let dir = TempDir::new("datafile").unwrap();
    let file_path = dir.path().join("foo.txt");
    let mut fs = OpenOptions::new()
        .read(true)
        .write(true)
        .append(true)
        .create(true)
        .open(file_path)
        .unwrap();

    for i in 0..10 {
        let mut entry = Entry::new(
            format!("{}", i).as_bytes().to_vec(),
            format!("{}", i).as_bytes().to_vec(),
            100,
        );
        assert!(entry.encode(&mut fs).is_ok())
    }
    assert!(fs.seek(SeekFrom::Start(0)).is_ok());

    for i in 0..10 {
        let entry = Entry::decode(&mut fs);
        assert!(entry.is_ok());
        println!("{:?}", to_string(&entry.unwrap()).unwrap());
    }
}

#[test]
fn data_file_core_samples() {}
