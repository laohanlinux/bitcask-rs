use byteorder::{BigEndian, WriteBytesExt};
use std::io::Cursor;

pub trait Key {
    fn to_vec(&self) -> Vec<u8>;
}

impl Key for isize {
    fn to_vec(&self) -> Vec<u8> {
        use std::io::Write;
        let mut v = vec![8; 0];
        let mut cur = Cursor::new(v);
        cur.write_i64::<BigEndian>(*self as i64).unwrap();
        cur.into_inner()
    }
}

impl Key for i64 {
    fn to_vec(&self) -> Vec<u8> {
        use std::io::Write;
        let mut cur = Cursor::new(vec![8; 0]);
        cur.write_i64::<BigEndian>(*self).unwrap();
        cur.into_inner()
    }
}

impl Key for i32 {
    fn to_vec(&self) -> Vec<u8> {
        use std::io::Write;
        let v = vec![4; 0];
        let mut cur = Cursor::new(v);
        cur.write_i32::<BigEndian>(*self).unwrap();
        cur.into_inner()
    }
}

pub trait Value: Into<Vec<u8>> {}

#[test]
fn tests() {}
