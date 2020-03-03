.DEFAULT_GOAL: w.build
w.build: deps
	rm -rf dist/ .cache/ed25519**/
	wasm-pack --verbose build --out-name index --out-dir ../.cache/ed25519wars rust
	# npm run inline
	node node_modules/.bin/webpack
dev: w.build
	node node_modules/.bin/webpack-dev-server --open -d
test:
	cargo test 
	# wasm-pack test --headless --chrome rust


# DEPS
deps: install-rust
	@rustc --version | grep -E 'nightly.*2019-12-14' $s || rustup override set nightly-2019-12-14
	# @cargo ndk --version | grep 0.4.1 $s || cargo install cargo-ndk --version 0.4.1
	# @rustup target add wasm32-unknown-unknown aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android aarch64-apple-ios armv7-apple-ios armv7s-apple-ios x86_64-apple-ios i386 $s
	@test -d node_modules || npm install
install-rust: 		# install manually: build-essential, pkg-config
	@rustup --version $s || curl https://sh.rustup.rs -sSf | sh -s -- -y
s = 2>&1 >/dev/null

rm.cache:
	rm -rf node_modules/ package-lock.json rust/target rust2/target/ target/