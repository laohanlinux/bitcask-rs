use crate::data_file::DataFile;
use crate::entry::Entry;
use crate::error::Result;
use crate::hint::Hint;
use crate::radix_tree::{Index, Indexer};
use crate::{BitCask, UnexpectedError};
use std::collections::HashMap;
use std::fs::read_dir;
use std::path::Path;

pub(crate) fn get_data_files(path: &str) -> Result<Vec<String>> {
    let entries = read_dir(path)
        .map_err(|err| UnexpectedError(err.to_string()))?
        .filter(|res| res.is_ok())
        .map(|dir| {
            let dir = dir.unwrap().path().clone();
            dir.to_string_lossy().to_string()
        })
        .collect::<Vec<_>>();
    let mut ps = entries
        .into_iter()
        .filter(|file| file.ends_with(".data"))
        .collect::<Vec<_>>();
    ps.sort();
    Ok(ps)
}

// Return sorted data file ids
pub(crate) fn parse_file_ids(data_files: &mut Vec<String>) -> Result<Vec<u64>> {
    let mut data_file_ids = data_files
        .iter_mut()
        .map(|data_file| {
            Path::new(data_file)
                .file_prefix()
                .unwrap()
                .to_string_lossy()
                .parse()
                .unwrap()
        })
        .collect::<Vec<u64>>();
    data_file_ids.sort();
    Ok(data_file_ids)
}

pub(crate) fn load_index_from_data_file(hint: &mut Indexer<Hint>, df: &mut DataFile) -> Result<()> {
    let mut offset = 0;
    loop {
        match df.read() {
            Ok(entry) => {
                if entry.value.is_empty() {
                    hint.remove(&entry.key);
                    continue;
                }
                let hint_entry = Hint::new(df.file_id(), offset, df.size(), entry.expiry);
                hint.insert(entry.key.clone(), hint_entry);
                offset += entry.size() as u64;
            }
            Err(err) if err.is_io_eof() => break,
            Err(err) => return Err(err),
        }
    }

    Ok(())
}

pub(crate) fn expire_key() -> impl FnMut(&Entry) -> bool {
    |entry: &Entry| -> bool { entry.expiry < chrono::Utc::now().timestamp() }
}
