.PHONY: build test ghcid


build: src/config.org xmonad-config.cabal
				bin/build --quiet

test:
				make build
				bin/test

ghcid:
				ghcid --restart=src/config.org \
					  --restart=xmonad-config.cabal \
					  --command="ntangle src/config.org; stack repl"
