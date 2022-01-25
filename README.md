# bitcask-rs
![example workflow name](https://github.com/laohanlinux/bitcask-rs/workflows/Rust/badge.svg)

```rust
use bitcask::BitCask;

let bitcask = BitCask::open("db", Config::default()).unwrap();
bitcask.put(vec![1, 2,3], vec![10, 11, 12, 13, 14, 15]);
let value  = bitcask.get(&vec![1, 2,3]).unwrap();
```
