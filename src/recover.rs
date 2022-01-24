use crate::codec::{Decode, Encode};
use crate::entry::Entry;
use crate::error::BitCaskError::UnexpectedError;
use crate::error::{BitCaskError, Result};
use crate::util::get_data_files;
use crate::{config, Config};
use crate::{data_file, Hint};
use log::{debug, warn};
use std::cell::RefCell;
use std::fs::{remove_file, File};
use std::path::Path;

// Checks and recovers the last datafile.
// If the datafile isn't corrupted, this is a noop. If it is,
// the longest non-corrupted prefix will be kept and the reset
// will be *deleted*. Also, the index file is also *deleted* which
// will be automatically recreated on next startup.
pub fn check_and_recover(path: &str, cfg: &config::Config) -> Result<()> {
    let dfs = get_data_files(path)?;
    if dfs.is_empty() {
        debug!("not found any data files，path: {}", path);
        return Ok(());
    }
    // recover the last file.
    let f = dfs.last().unwrap();
    let recovered = data_file::recover_last_data_file(f, cfg)?;
    // because the last data file is dirty, so rebuild the hint
    if recovered {
        remove_file(Path::new(path).join(Hint::HINT_FILE))
            .map_err(|err| UnexpectedError(err.to_string()))?;
        debug!(
            "{} index file had removed",
            Path::new(path).join("index").to_str().unwrap()
        );
    }
    Ok(())
}
