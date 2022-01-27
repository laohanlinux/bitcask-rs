use crate::error::Result;
use memmap::{Mmap, MmapMut};

use crate::UnexpectedError;
use std::fs::{create_dir_all, File, OpenOptions};
use std::io::{Seek, SeekFrom, Write};
use std::ops::{Deref, DerefMut};
use std::path::Path;

pub fn bind_mmap(fp: &File) -> Result<MmapMut> {
    let mmap = unsafe { Mmap::map(fp).map_err(|err| UnexpectedError(err.to_string()))? };
    let mut wt = mmap
        .make_mut()
        .map_err(|err| UnexpectedError(err.to_string()));
    wt
}

pub fn bind_mmap_and_write(fp: &mut File, offset: usize, buffer: &[u8]) -> Result<()> {
    let mut mmap = bind_mmap(&fp)?;
    let mut wt = mmap.deref_mut();
    let mut wt = &mut wt[offset..(offset + buffer.len())];
    wt.write_all(buffer)
        .map_err(|err| UnexpectedError(err.to_string()))?;
    Ok(())
}

pub struct MMapFile {
    fp: File,
    mmap: Option<MmapMut>,
}

impl MMapFile {
    pub fn new(fp: File) -> Result<MMapFile> {
        Ok(MMapFile { fp, mmap: None })
    }

    pub fn append(&mut self, buffer: &[u8]) -> Result<()> {
        if buffer.is_empty() {
            return Ok(());
        }
        let offset = self.extract_len(buffer.len() as u64)?;
        let mmap = self.mmap.as_mut().unwrap();
        let mut wt = &mut mmap.deref_mut()[offset as usize..(offset as usize + buffer.len())];
        wt.copy_from_slice(buffer);
        Ok(())
    }

    pub fn flush(&mut self) -> Result<()> {
        if let Some(ref mmap) = self.mmap {
            mmap.flush()
                .map_err(|err| UnexpectedError(err.to_string()))?;
        }
        self.fp
            .flush()
            .map_err(|err| UnexpectedError(err.to_string()))?;
        Ok(())
    }

    fn extract_len(&mut self, n: u64) -> Result<u64> {
        let cur_sz = self
            .fp
            .stream_len()
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let extract_sz = cur_sz + n;
        if let Some(mmap) = self.mmap.take() {
            drop(mmap);
        }
        self.fp
            .set_len(extract_sz)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let mmap = bind_mmap(&self.fp).map_err(|err| UnexpectedError(err.to_string()))?;
        self.mmap = Some(mmap);
        Ok(cur_sz)
    }
}
