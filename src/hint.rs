use crate::codec::{Decode, Encode, KeyValue};
use crate::error::BitCaskError::{NoMoreData, UnexpectedError};
use byteorder::{BigEndian, ReadBytesExt, WriteBytesExt};
use kv_log_macro::debug;
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};
use std::io::{Cursor, Read, Seek, Write};
use log::info;

// `Item` represents the location of the value on disk. This is used by the
// internal Adaptive Radix Tree to hold an in-memory structure mapping keys to
// locations on disk of where the value(s) can be read from.(Only one Hint, not same to raw bitcask)
// or use other filed high bit to flag it.
#[derive(Debug, Clone, PartialEq, Default, Serialize, Deserialize)]
pub(crate) struct Hint {
    pub(crate) file_id: u64,
    pub(crate) offset: u64,
    pub(crate) size: u64,
    pub(crate) expire: Option<i64>,
}

impl Hint {
    pub(crate) const SIZE: u64 = 8 + 8 + 8 + 8;
    pub(crate) const HINT_FILE: &'static str = "hint_index";
    pub(crate) fn new(file_id: u64, offset: u64, sz: u64, expire: i64) -> Self {
        let mut hint = Hint {
            file_id,
            offset,
            size: sz,
            expire: None,
        };
        if expire > 0 {
            hint.expire = Some(expire);
        }
        hint
    }
    pub(crate) fn expiry(&self) -> i64 {
        self.expire.unwrap_or_default()
    }
    pub(crate) fn is_expire(&self) -> bool {
        if let Some(expire) = self.expire {
            expire > 0 && expire <= chrono::Utc::now().timestamp()
        } else {
            false
        }
    }
}

impl From<Vec<u8>> for Hint {
    fn from(v: Vec<u8>) -> Self {
        let mut rd = Cursor::new(v);
        Self::decode(&mut rd).unwrap()
    }
}

impl Display for Hint {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "(file_id: {}, offset: {}, size: {}, expire: {})",
            self.file_id,
            self.offset,
            self.size,
            self.expire.unwrap_or_default()
        )
    }
}

impl Decode<Hint> for Hint {
    #[inline]
    fn decode<Rd: Read>(fs: &mut Rd) -> crate::error::Result<Hint> {
        let mut item = Hint::default();
        item.file_id = {
            match fs.read_u64::<BigEndian>() {
                Ok(file_id) => file_id,
                Err(err) if err.kind() == std::io::ErrorKind::UnexpectedEof => {
                    return Err(NoMoreData);
                }
                Err(err) => return Err(UnexpectedError(err.to_string())),
            }
        };
        let expire_hi = item.file_id >> 63;
        item.file_id = item.file_id & 0x_7FFF_FFFF_FFFF_FFFF;
        item.offset = fs
            .read_u64::<BigEndian>()
            .map_err(|err| UnexpectedError(err.to_string()))?;
        item.size = fs
            .read_u64::<BigEndian>()
            .map_err(|err| UnexpectedError(err.to_string()))?;
        if expire_hi > 0 {
            item.expire = Some(fs.read_i64::<BigEndian>().map_err(|err| UnexpectedError(err.to_string()))?);
        }
        Ok(item)
    }
}

impl Encode for Hint {
    #[inline]
    fn encode<Wt: Write>(&self, fs: &mut Wt) -> crate::error::Result<()> {
        let expire = self.expiry();
        let mut buffer_sz = Self::SIZE;
        let mut file_id = self.file_id;
        if expire <= 0 {
            buffer_sz -= 8;
        } else {
            file_id = self.file_id | 0x_8000_0000_0000_0000;
        }
        let mut cursor = Cursor::new(Vec::with_capacity(buffer_sz as usize));
        cursor
            .write_u64::<BigEndian>(file_id)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        cursor
            .write_u64::<BigEndian>(self.offset)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        cursor
            .write_u64::<BigEndian>(self.size)
            .map_err(|err| UnexpectedError(err.to_string()))?;
        let expire = self.expiry();
        if expire > 0 {
            cursor
                .write_i64::<BigEndian>(expire)
                .map_err(|err| UnexpectedError(err.to_string()))?;
        }
        fs.write(&cursor.into_inner())
            .map_err(|err| UnexpectedError(err.to_string()))?;
        Ok(())
    }
}

#[test]
fn hint_decode_encode() {
    use rand::random;
    for i in 0..100000 {
        let file_id = random::<u32>() as u64;
        let hint = Hint::new(file_id, 100000, 1 << 10, chrono::Utc::now().timestamp());
        if hint.file_id == u64::MAX {
            continue;
        }
        let mut encoder = Cursor::new(vec![]);
        hint.encode(&mut encoder).unwrap();
        encoder.set_position(0);
        let decode_hint = Hint::decode(&mut encoder).unwrap();
        assert_eq!(hint, decode_hint);
    }
}
