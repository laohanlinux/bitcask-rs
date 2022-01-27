#[macro_use]
extern crate criterion;

use bitcask_rs::mmap;
use criterion::{black_box, BenchmarkId, Criterion};
use std::fs::OpenOptions;

use pprof::criterion::{Output, PProfProfiler};

fn batch_mmap(buffer: &Vec<u8>) {
    let start = chrono::Utc::now();
    let mut mmap = mmap::MMapFile::new("/tmp/mmap").unwrap();
    mmap.append(buffer).unwrap();
    mmap.flush().unwrap();
    println!(
        "total: {}, cost: {:?}ms",
        buffer.len(),
        chrono::Utc::now().timestamp_millis() - start.timestamp_millis()
    );
}

fn bench(c: &mut Criterion) {
    let buffer = generate_n_sz_buffer(1 << 30);
    c.bench_function("batch-mmap", |b| b.iter(|| batch_mmap(black_box(&buffer))));
}

fn generate_n_sz_buffer(n: usize) -> Vec<u8> {
    use rand::{distributions::Alphanumeric, Rng};
    let value = rand::thread_rng()
        .sample_iter(&Alphanumeric)
        .take(n)
        .map(char::from)
        .collect::<String>()
        .into_bytes();
    value
}

fn bench_group(c: &mut Criterion) {
    let mut group = c.benchmark_group("Mmap Sizes");
    let input = vec![
        generate_n_sz_buffer(1 << 20),
        generate_n_sz_buffer(1 << 21),
        generate_n_sz_buffer(1 << 25),
        generate_n_sz_buffer(1 << 30),
    ];
    for s in input {
        group.bench_with_input(BenchmarkId::from_parameter(s.len()), &s, |b, s| {
            b.iter(|| batch_mmap(black_box(&s)))
        });
    }
}

criterion_group! {
    name = benches;
    config = Criterion::default().with_profiler(PProfProfiler::new(100, Output::Flamegraph(None)));
    targets = bench, bench_group
}

criterion_main!(benches);
