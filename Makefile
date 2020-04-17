.PHONY: build test


build: src/config.org xmonad-config.cabal
				bin/build

test:
				make build
				bin/test
