use tempdir::TempDir;

pub fn sure_tmp_dir(prefix: &str) -> String {
    let dir = TempDir::new(prefix).unwrap();
    let dir = dir.as_ref().to_string_lossy();
    dir.to_string()
}
