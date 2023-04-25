.SHELLFLAGS = -c 'echo $$1 > tmp.rs && rustc tmp.rs -o out.bin && ./out.bin' --

.ONESHELL:
all:
	@fn main() {
		println!("hello make!")
	}
