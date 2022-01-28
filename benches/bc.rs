#[macro_use]
extern crate criterion;

use criterion::{black_box, BenchmarkId, Criterion};
use log::kv::ToValue;
use std::io::SeekFrom::Current;
use std::io::{BufReader, Cursor};
use std::path;
use std::path::Path;

use pprof::criterion::{Output, PProfProfiler};

fn bitcask(arg: (Vec<Vec<u8>>, Vec<u8>, u64)) {
    let (key, value, df_sz) = arg;
    let dir = tempdir::TempDir::new("bc").unwrap();
    let cfg = bitcask_rs::Config::default()
        .auto_merge(false)
        .set_max_data_file_size(df_sz)
        .set_check_sum_at_get_key(false);
    let bitcask = bitcask_rs::BitCask::open(dir.path(), cfg).unwrap();
    let start = chrono::Utc::now();
    let n = key.len();
    for key in key {
        bitcask.put(key, value.clone()).unwrap();
    }

    let cost = chrono::Utc::now().timestamp_millis() - start.timestamp_millis();
    println!(
        "key-count:{}, value-sz:{}, df_sz: {}m, cost: {}ms, avg: {}ms",
        n,
        value.len(),
        df_sz / 1024 / 1024,
        cost,
        cost as f64 / n as f64,
    );
}

fn bench(c: &mut Criterion) {
    let mut keys = vec![];
    for i in 0..500000 {
        keys.push(format!("{}", i).as_bytes().to_vec());
    }
    let value = generate_buffer(512);
    c.bench_function("bitcask", |b| {
        b.iter(|| bitcask(black_box((keys.clone(), value.clone(), 100 * 1 << 20))))
    });
}

fn bench_group(c: &mut Criterion) {
    let mut group = c.benchmark_group("Bitcask Sizes");
    let mut input: Vec<(Vec<Vec<u8>>, Vec<u8>, u64)> = Vec::new();
    for i in vec![128, 256, 1024, 2048, 4096, 8192, 16384, 32768] {
        let mut keys = vec![];
        for i in 0..100000 {
            keys.push(format!("{}", i).as_bytes().to_vec());
        }
        let value = generate_buffer(i);
        input.push((keys, value, 200 * 1 << 20));
    }

    for s in input {
        group.bench_with_input(BenchmarkId::from_parameter(s.1.len()), &s, |b, s| {
            b.iter(|| bitcask(black_box(s.clone())))
        });
    }
}

criterion_group! {
    name = benches;
    config = Criterion::default().with_profiler(PProfProfiler::new(100, Output::Flamegraph(None)));
    targets = bench, bench_group
}

criterion_main!(benches);

fn generate_buffer(n: usize) -> Vec<u8> {
    use bra::GreedyAccessReader;
    use std::io::Read;
    let mut buffer = vec![0; n];
    let mut rd = Cursor::new(buffer);
    let mut reader = GreedyAccessReader::new(rd);
    let s = reader.slice(0..n).unwrap();
    s.to_vec()
}
