.SHELLFLAGS = -c ' \
	mkdir -p .makerust && \
	echo "$$1" > .makerust/tmp.rs && \
	if [ "$$(head -1 .makerust/tmp.rs)" = "dep" ]; then \
		bash -c "`tail -n +2 .makerust/tmp.rs`" >> .makerust/dep; \
	else \
		printf "\#!/usr/bin/env cargo\n" > .makerust/tmp.rs && \
		printf -- "---cargo\n" >> .makerust/tmp.rs && \
		printf "package.edition = \"2024\"\n" >> .makerust/tmp.rs && \
		printf "[dependencies]\n" >> .makerust/tmp.rs && \
		if [ -f ".makerust/dep" ]; then \
			for dep in $$(sort .makerust/dep | uniq); do \
				printf "$${dep}=\"*\"\n" >> .makerust/tmp.rs; \
			done; \
		fi; \
		printf -- "---\n" >> .makerust/tmp.rs && \
		echo "$$1" >> .makerust/tmp.rs && \
		cargo +nightly -q -Zscript .makerust/tmp.rs && \
		rm -f .makerust/dep; \
	fi \
' --

dep.%:
	@dep
	echo "$(subst dep.,,$@)"

.ONESHELL:

