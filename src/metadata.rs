use crate::error::Result;
use crate::UnexpectedError;
use kv_log_macro::debug;
use serde::{Deserialize, Serialize};
use std::fs::File;
use std::io::Bytes;
use std::path::{Path, PathBuf};
use std::ptr::write_bytes;

#[derive(Default, Serialize, Deserialize)]
pub struct MetaData {
    pub(crate) index_up_to_date: bool,
    pub(crate) total_space_used: u64,
    pub(crate) dirty_space: u64,
}

impl MetaData {
    pub const NAME: &'static str = "metadata.toml";
    pub fn save<P: AsRef<Path>>(&self, path: P) -> Result<()> {
        let path = path.as_ref().join(Self::NAME);
        let path = path.as_os_str();
        let buf = toml::to_vec(&self).unwrap();
        ::std::fs::write(path, buf).map_err(|err| UnexpectedError(err.to_string()))?;
        debug!("save metadata: {}", path.to_string_lossy());
        Ok(())
    }

    pub fn load(path: PathBuf) -> Result<Self> {
        let buf =
            ::std::fs::read_to_string(path).map_err(|err| UnexpectedError(err.to_string()))?;
        toml::from_str(&*buf).map_err(|err| UnexpectedError(err.to_string()))
    }

    pub fn load_and_create(path: &str) -> Result<Self> {
        let p = Path::new(path).join(Self::NAME);
        if !p.exists() {
            debug!("not found the {:?}, create a new", p.as_os_str());
            let metadata = MetaData::default();
            metadata.save(path)?;
            return Ok(metadata);
        }
        Self::load(p)
    }
}
