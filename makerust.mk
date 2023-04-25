.SHELLFLAGS = -c ' \
	mkdir -p .makerust && \
	echo "$$1" > .makerust/tmp.rs && \
	if [[ "$$(head -1 .makerust/tmp.rs)" = "dep" ]]; then \
		bash -c "`tail -n +2 .makerust/tmp.rs`" >> .makerust/dep; \
	else \
		printf "[package]\nname=\"makerust\"\nversion=\"0.1.0\"\nedition=\"2021\"\n" > .makerust/Cargo.toml && \
		printf "[[bin]]\npath=\"tmp.rs\"\nname=\"bin\"\n" >> .makerust/Cargo.toml && \
		printf "[dependencies]\n" >> .makerust/Cargo.toml && \
		if [[ -f ".makerust/dep" ]]; then \
			for dep in $$(sort .makerust/dep | uniq); do \
				printf "$${dep}=\"*\"\n" >> .makerust/Cargo.toml; \
			done; \
		fi; \
		cargo run -q --manifest-path .makerust/Cargo.toml; \
		rm -f .makerust/dep; \
	fi \
' --

dep.%:
	@dep
	echo "$(subst dep.,,$@)"

.ONESHELL:

