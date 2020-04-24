.PHONY: build test


build: src/config.org xmonad-config.cabal
				bin/build --quiet

test:
				make build
				bin/test
