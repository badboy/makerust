include makerust.mk

hello-world:
	@fn main() {
		println!("hello makerust!")
	}

info: dep.xshell dep.anyhow
	@
	use anyhow::Result;
	use xshell::{cmd, Shell};
	
	fn main() -> Result<()> {
		let sh = Shell::new()?;
		let branch = "main";
		let commit_hash = cmd!(sh, "git rev-parse {branch}").read()?;
		println!("makerust running on commit {commit_hash}");
		Ok(())
	}
