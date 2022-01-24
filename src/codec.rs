use crate::error::Result;
use std::io::{Read, Write};

pub(crate) trait Encode {
    fn encode<Wt: Write>(&self, fs: &mut Wt) -> Result<()>;
}

pub(crate) trait Decode<T> {
    fn decode<Rd: Read>(fs: &mut Rd) -> Result<T>;
}

// todo: maybe return value reference
pub(crate) trait KeyValue<K, V> {
    fn key_value(self) -> (K, V);
}
