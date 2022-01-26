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
        let n = 10000;
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
        use env_logger::Builder;
        use log::LevelFilter;
        use std::io::Write;

        // {
        //     let mut builder = Builder::from_default_env();
        //     builder
        //         .format(|buf, record| writeln!(buf, "[{} {} {}:{}] {}", chrono::Local::now(), record.level(), record.file_static().unwrap(), record.line().unwrap() , record.args()))
        //         .filter(None, LevelFilter::Debug)
        //         .try_init();
        // }

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
