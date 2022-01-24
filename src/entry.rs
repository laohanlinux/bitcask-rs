use crate::codec::{Decode, Encode, KeyValue};
use crate::error::BitCaskError::{NoMoreData, UnexpectedError};
use crate::error::{BitCaskError, Result};
use byteorder::{BigEndian, ReadBytesExt, WriteBytesExt};
use bytes::Bytes;
use crc::{Crc, CRC_32_CKSUM};
use log::debug;
use serde::{Deserialize, Serialize};
use std::cell::{RefCell, RefMut};
use std::fmt::{Display, Formatter};
use std::fs::File;
use std::io::SeekFrom::Current;
use std::io::{BufReader, BufWriter, Cursor, Read, Write};

// key_sz: value_sz: ttl: key: value: crc
#[derive(Default, Clone, Debug, PartialEq, Serialize, Deserialize)]
pub(crate) struct Entry {
    pub(crate) check_sum: u32,
    pub(crate) key: Vec<u8>,
    pub(crate) value: Vec<u8>,
    pub(crate) expiry: i64,
}

impl Display for Entry {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        if let Ok(key) = String::from_utf8(self.key.clone()) {
            write!(
                f,
                "key: {:?}, expiry: {}, size: {}",
                key,
                self.expiry,
                self.size()
            )
        } else {
            write!(
                f,
                "key: {:?}, expiry: {}, size: {}",
                self.key,
                self.expiry,
                self.size()
            )
        }
    }
}

pub const CRC32: Crc<u32> = Crc::<u32>::new(&CRC_32_CKSUM);

impl Entry {
    const KEY_SIZE: usize = 4;
    const VALUE_SIZE: usize = 8;
    const CHECKSUM_SIZE: usize = 4;
    const TTL_SIZE: usize = 8;
    pub const MATA_INFO_SIZE: usize =
        Self::KEY_SIZE + Self::VALUE_SIZE + Self::CHECKSUM_SIZE + Self::TTL_SIZE;

    pub(crate) fn new(key: Vec<u8>, value: Vec<u8>, expiry: i64) -> Entry {
        let check_sum = CRC32.checksum(&value);
        Self {
            check_sum,
            key,
            value,
            expiry,
        }
    }

    pub(crate) fn size(&self) -> usize {
        return Self::MATA_INFO_SIZE + self.key.len() + self.value.len();
    }

    pub(crate) fn from_vec(buf: Vec<u8>) -> Result<Entry> {
        let mut fs = Cursor::new(buf);
        Entry::decode(&mut fs)
    }

    pub(crate) fn from_slice(buf: &[u8]) -> Result<Entry> {
        let mut fs = Cursor::new(buf);
        let entry = Entry::decode(&mut fs)?;
        Ok(entry)
    }

    pub(crate) fn to_vec(&self) -> Result<Vec<u8>> {
        let mut fs = Cursor::new(vec![]);
        self.encode(&mut fs).unwrap();
        Ok(Vec::from(fs.into_inner()))
    }

    pub(crate) fn key_to_string(&self) -> String {
        String::from_utf8_lossy(&self.key).to_string()
    }
}

impl From<Vec<u8>> for Entry {
    fn from(v: Vec<u8>) -> Self {
        Entry::from_vec(v).unwrap()
    }
}

impl From<&[u8]> for Entry {
    fn from(slice: &[u8]) -> Self {
        Entry::from_slice(slice).unwrap()
    }
}

impl Encode for Entry {
    #[inline]
    fn encode<Wt: Write>(&self, fs: &mut Wt) -> Result<()> {
        let mut fs = BufWriter::new(fs);
        fs
            .write_u32::<BigEndian>(self.check_sum)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs
            .write_i64::<BigEndian>(self.expiry)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs
            .write_u32::<BigEndian>(self.key.len() as u32)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs
            .write_u64::<BigEndian>(self.value.len() as u64)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs
            .write(&*self.key)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs
            .write(&*self.value)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        // debug!("cur: {:?}", buffer);
        Ok(())
    }
}

impl Decode<Entry> for Entry {
    #[inline]
    fn decode<Rd: Read>(fs: &mut Rd) -> Result<Entry> {
        use byteorder::{BigEndian, ReadBytesExt};
        use bytes::Bytes;
        let mut entry = Entry::default();
        entry.check_sum = match fs.read_u32::<BigEndian>() {
            Ok(check_sum) => check_sum,
            Err(err) if err.kind() == std::io::ErrorKind::UnexpectedEof => return Err(NoMoreData),
            Err(err) => return Err(UnexpectedError(err.to_string())),
        };
        entry.expiry = fs
            .read_i64::<BigEndian>()
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        let key_sz = fs
            .read_u32::<BigEndian>()
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        let value_sz: u64 = fs
            .read_u64::<BigEndian>()
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        // TODO optimze, only read once
        entry.key = vec![0; key_sz as usize];
        entry.value = vec![0; value_sz as usize];
        fs.read(&mut entry.key)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        fs.read(&mut entry.value)
            .map_err(|err| BitCaskError::UnexpectedError(err.to_string()))?;
        Ok(entry)
    }
}

impl KeyValue<Vec<u8>, Entry> for Entry {
    #[inline]
    fn key_value(self) -> (Vec<u8>, Entry) {
        let key = self.key.clone();
        (key, self)
    }
}
