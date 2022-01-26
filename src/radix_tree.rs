use crate::codec::{Decode, Encode, KeyValue};
use crate::entry::Entry;
use crate::error::BitCaskError::NoMoreData;
use crate::error::{BitCaskError::UnexpectedError, Result};
use crate::hint::Hint;
use byteorder::{BigEndian, ReadBytesExt, WriteBytesExt};
use log::debug;
use qp_trie::{Iter, IterMut, Trie};
use serde::de::Unexpected::Bytes;
use serde::{Deserialize, Serialize};
use std::borrow::Borrow;
use std::error::Error;
use std::fmt::Display;
use std::fs::{File, OpenOptions};
use std::io::{BufReader, BufWriter, Cursor, Read, Seek, SeekFrom, Write};
use std::ops::Deref;
use std::sync::{Arc, Mutex};

// TODO
// 1: add async read/write
// 2: enc/dec into Hint
pub(crate) trait Persisted<V> {
    const KEY_SIZE: u64 = 8;
    const VALUE_SIZE: u64 = 8;
    type Item = V;
    fn save(&mut self, path: &str) -> Result<bool>;
    // if filter return false that will skip the item, and not encode it.
    fn load(&mut self, path: &str, filter: Option<impl FnMut(&V) -> bool>) -> Result<bool>;
}

pub(crate) trait Index<V> {
    fn get(&self, key: &Vec<u8>) -> Option<&V>;
    fn get_mut(&mut self, key: &Vec<u8>) -> Option<&mut V>;
    fn insert(&mut self, key: Vec<u8>, value: V) -> Option<V>;
    fn remove(&mut self, key: &Vec<u8>) -> Option<V>;
    fn clear(&mut self);
    fn iter(&self) -> Iter<Vec<u8>, V>;
    fn iter_prefix(&self, prefix: &Vec<u8>) -> Iter<Vec<u8>, V>;
    fn iter_mut(&mut self) -> IterMut<Vec<u8>, V>;
    fn iter_prefix_mut(&mut self, prefix: &Vec<u8>) -> IterMut<Vec<u8>, V>;
}

pub(crate) struct Indexer<V: Encode + Decode<V>> {
    store: Trie<Vec<u8>, V>,
}

impl<V> Indexer<V>
where
    V: Encode + Decode<V> + From<Vec<u8>>,
{
    pub(crate) fn new() -> Indexer<V> {
        Indexer { store: Trie::new() }
    }

    pub(crate) fn count(&self) -> usize {
        self.store.count()
    }
}

impl<V> Persisted<V> for Indexer<V>
where
    V: Encode + Decode<V> + From<Vec<u8>> + Display,
{
    fn save(&mut self, path: &str) -> Result<bool> {
        let fp = OpenOptions::new()
            .write(true)
            .create(true)
            .truncate(true)
            .open(path)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let mut fp = BufWriter::new(fp);
        for (key, entry) in self.store.iter() {
            assert!(!key.is_empty());
            let mut buffer = Cursor::new(vec![]);
            entry.encode(&mut buffer)?;
            let value = buffer.into_inner();
            assert!(value.len() <= 1 << 10);
            fp.write_u64::<BigEndian>(key.len() as u64)
                .map_err(|err| UnexpectedError(err.to_string()))?;
            fp.write_u64::<BigEndian>(value.len() as u64)
                .map_err(|err| UnexpectedError(err.to_string()))?;
            fp.write(key)
                .map_err(|err| UnexpectedError(err.to_string()))?;
            fp.write(&value)
                .map_err(|err| UnexpectedError(err.to_string()))?;
        }
        fp.flush().map_err(|err| UnexpectedError(err.to_string()))?;
        Ok(true)
    }

    // TODO: optimize use buffer fp
    fn load(&mut self, path: &str, mut filter: Option<impl FnMut(&V) -> bool>) -> Result<bool> {
        let mut total = 0;
        let mut distinct_count = 0;
        let mut filter_count = 0;
        match OpenOptions::new().read(true).open(path) {
            Ok(mut fp) => {
                loop {
                    let key_sz = {
                        match fp.read_u64::<BigEndian>() {
                            Ok(sz) => sz,
                            Err(err) if err.kind() == std::io::ErrorKind::UnexpectedEof => break,
                            Err(err) => return Err(UnexpectedError(err.to_string())),
                        }
                    };
                    let value_sz = fp
                        .read_u64::<BigEndian>()
                        .map_err(|err| UnexpectedError(err.to_string()))?;
                    assert!(value_sz < 1 << 10);
                    let mut key = vec![0; key_sz as usize];
                    let mut value = vec![0; value_sz as usize];
                    fp.read(&mut key)
                        .map_err(|err| UnexpectedError(err.to_string()))?;
                    fp.read(&mut value)
                        .map_err(|err| UnexpectedError(err.to_string()))?;
                    let mut buffer = Cursor::new(value);
                    let entry = V::decode(&mut buffer)?;
                    debug!(
                        "start to loader, key:{}, entry: {}",
                        String::from_utf8_lossy(&key),
                        entry,
                    );
                    total += 1;
                    if let Some(ref mut filter) = filter {
                        if (filter)(&entry) {
                            if self.store.insert(key, entry).is_none() {
                                distinct_count += 1;
                            }
                        } else {
                            filter_count += 1;
                            debug!("skip {} at load hint", String::from_utf8_lossy(&key));
                        }
                    } else {
                        if self.store.insert(key, entry).is_none() {
                            distinct_count += 1;
                        }
                    }
                }
                debug!(
                    "store loader stats, total: {}, distinct_count: {}, filter_count: {}",
                    total, distinct_count, filter_count
                );
                Ok(true)
            }
            Err(err) if err.kind() == std::io::ErrorKind::NotFound => Ok(false),
            Err(err) => Err(UnexpectedError(err.to_string())),
        }
    }
}

impl<V> Index<V> for Indexer<V>
where
    V: Encode + Decode<V> + From<Vec<u8>>,
{
    fn get(&self, key: &Vec<u8>) -> Option<&V> {
        self.store.get(key)
    }

    fn get_mut(&mut self, key: &Vec<u8>) -> Option<&mut V> {
        self.store.get_mut(key)
    }

    fn insert(&mut self, key: Vec<u8>, value: V) -> Option<V> {
        self.store.insert(key, value)
    }

    fn remove(&mut self, key: &Vec<u8>) -> Option<V> {
        self.store.remove(key)
    }

    fn clear(&mut self) {
        self.store.clear()
    }

    fn iter(&self) -> Iter<Vec<u8>, V> {
        self.store.iter()
    }

    fn iter_prefix(&self, prefix: &Vec<u8>) -> Iter<Vec<u8>, V> {
        self.store.iter_prefix(prefix)
    }

    fn iter_mut(&mut self) -> IterMut<Vec<u8>, V> {
        self.store.iter_mut()
    }

    fn iter_prefix_mut(&mut self, prefix: &Vec<u8>) -> IterMut<Vec<u8>, V> {
        self.store.iter_prefix_mut(prefix)
    }
}

#[test]
fn radix_tree() {
    use names::{Generator, Name};
    use tempdir::TempDir;

    fn filter(v: Vec<i64>, f: Option<impl FnMut(&i64) -> bool>) -> Vec<i64> {
        let f = f.unwrap();
        let v = v.into_iter().filter(f).collect::<Vec<_>>();
        v
    }

    let dir = TempDir::new("my_directory_prefix").unwrap();
    let file_path = dir.path().join("trie.index");
    let mut tree = Indexer::new();
    let mut name_g = Generator::with_naming(Name::Numbered);
    for i in 0..10 {
        let key = name_g.next().unwrap().into_bytes();
        let value = name_g.next().unwrap().into_bytes();
        tree.insert(key.clone(), Entry::new(key, value, i));
    }

    let ok = tree.save(file_path.to_str().unwrap()).unwrap();
    assert!(ok);
}

#[test]
fn random_radix_tree() {
    use crate::tests_util;
    use rand::random;
    let mut index = Indexer::new();
    let n = 1000000;
    for i in 0..n {
        let hint = Hint::new(i, i + 1, i + 2, 60);
        let key = random::<usize>();
        index.insert(format!("{}", key).into_bytes(), hint);
    }
    for i in 0..n {
        index.remove(&format!("{}", i).into_bytes());
    }
    let dir = tests_util::sure_tmp_dir("index");
    let ok = index.save(&dir);
    assert!(ok.is_ok());
    let mut index2 = Indexer::new();
    let ok = index2.load(&dir, None::<fn(&Hint) -> bool>);
    assert!(ok.is_ok());
    assert_eq!(index.count(), index2.count());
    for (key1, value1) in index.iter() {
        let value2 = index.get(key1).unwrap();
        assert_eq!(value1, value2);
    }
}
