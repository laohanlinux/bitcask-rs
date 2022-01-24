use std::io;
use thiserror::Error;

#[derive(Debug, Error)]
pub enum BitCaskError {
    #[error("can't not open file: {0}")]
    FailedOpenDB(String),
    #[error("IO error: {0}")]
    Io(#[source] Box<io::Error>),
    #[error("unexpected error: {0}")]
    UnexpectedError(String),
    #[error("key or value size is invalid")]
    InvalidKeyOrValue,
    #[error("can't decode on empty entry")]
    DecodeOnEmptyEntry,
    #[error("data is truncated")]
    TruncatedData,
    #[error("empty key")]
    EmptyKey,
    #[error("too large key")]
    TooLargeKey,
    #[error("too large value")]
    TooLargeValue,
    #[error("no more data")]
    NoMoreData,
    #[error("expired key")]
    ExpiredKey,
    #[error("merging")]
    AtMerging,
}

impl From<io::Error> for BitCaskError {
    #[inline]
    fn from(e: io::Error) -> Self {
        BitCaskError::Io(Box::new(e))
    }
}

impl BitCaskError {
    pub fn is_io_eof(&self) -> bool {
        match self {
            BitCaskError::Io(err) if err.kind() == io::ErrorKind::UnexpectedEof => true,
            BitCaskError::NoMoreData => true,
            _ => false,
        }
    }

    // Indicates if the error correspondes to possible data corruption
    pub fn is_corrupted_data(&self) -> bool {
        match self {
            BitCaskError::DecodeOnEmptyEntry
            | BitCaskError::TruncatedData
            | BitCaskError::InvalidKeyOrValue => true,
            _ => false,
        }
    }
}

pub type Result<T> = std::result::Result<T, BitCaskError>;
