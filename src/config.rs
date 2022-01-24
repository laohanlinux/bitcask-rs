use crate::error::{BitCaskError, Result};
use serde::{Deserialize, Serialize};
use std::fs;
use std::fs::{File, FileType};
use std::path::PathBuf;

#[derive(Clone, Serialize, Deserialize)]
pub struct Config {
    pub max_data_file_size: u64,
    pub max_key_size: u32,
    pub max_value_size: u64,
    pub sync: bool,
    pub auto_recovery: bool,
    pub db_version: u32,
    pub check_sum_at_get_key: bool,
    pub auto_merge: bool,
}

impl Config {
    pub fn save(&self, path: PathBuf) -> Result<()> {
        fs::write(path, toml::to_vec(&self).unwrap())
            .map_err(|err| BitCaskError::FailedOpenDB(err.to_string()))
    }
    pub fn load(path: PathBuf) -> Result<Self> {
        let buf = fs::read_to_string(path)?;
        toml::from_str(&*buf).map_err(|err| BitCaskError::FailedOpenDB(err.to_string()))
    }

    pub fn set_max_data_file_size(mut self, size: u64) -> Self {
        self.max_data_file_size = size;
        self
    }

    pub fn set_max_key_size(mut self, size: u32) -> Self {
        self.max_key_size = size;
        self
    }

    pub fn set_max_value_size(mut self, size: u64) -> Self {
        self.max_value_size = size;
        self
    }

    pub fn auto_sync(mut self, auto_sync: bool) -> Self {
        self.sync = auto_sync;
        self
    }

    pub fn set_auto_recover(mut self, auto_recover: bool) -> Self {
        self.auto_recovery = auto_recover;
        self
    }

    pub fn set_check_sum_at_get_key(mut self, checked: bool) -> Self {
        self.check_sum_at_get_key = checked;
        self
    }

    pub fn auto_merge(mut self, auto_merge: bool) -> Self {
        self.auto_merge = auto_merge;
        self
    }
}

impl Default for Config {
    fn default() -> Self {
        Config {
            max_data_file_size: 1 << 20,
            max_key_size: 1 << 10,
            max_value_size: 1 << 20,
            sync: true,
            auto_recovery: true,
            db_version: 1,
            check_sum_at_get_key: false,
            auto_merge: false,
        }
    }
}
