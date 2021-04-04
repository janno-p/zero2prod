# Zero to Production

```sh
sudo apt install postgresql-client
cargo install --version=0.5.1 sqlx-cli --no-default-features --features postgres
SKIP_DOCKER=true ./scripts/init_db.sh
```


```sh
$ rustup component add clippy
$ rustup component add rustfmt

$ cargo install cargo-tarpaulin
$ cargo install cargo-audit
$ cargo install cargo-edit
$ cargo install cargo-expand
$ cargo install --locked --version=0.5.1 sqlx-cli --no-default-features --features postgres
$ cargo install cargo-udeps

$ cargo tarpaulin --ignore-tests
$ cargo clippy
$ cargo fmt
$ cargo audit

```
