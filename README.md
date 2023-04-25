# makerust

### Rust, but in a Makefile.

Have you ever thought "I want to write Rust, but in a Makefile"?
No?
Well, I have.

So I present to you: `makerust`.

```make
hello-world:
	@fn main() {
		println!("hello makerust!")
	}
```

```console
$ make hello-world
hello makerust!
```

Need some dependencies?
`makerust` handles that.

```make
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
```

```console
$ make info
makerust running on commit 5a9c640331fa11cfff0f3147732b49e8b247f687
```


## How?

```make
include makerust.mk
```

and then get going.

## Why?

make is good. Rust is good. In combination it can only get better.

## Should I really?

Check with your team first, but I can't see a reason why not.

## This is a joke, right?

I don't make jokes on the internet.

---

```
Any copyright is dedicated to the Public Domain.
http://creativecommons.org/publicdomain/zero/1.0/
```
