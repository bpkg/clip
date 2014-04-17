
BIN ?= clip
PREFIX ?= /usr/local

export CLIP_FILE ?= ./.test_clip

install:
	install $(BIN) $(PREFIX)/bin

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)

test:
	./test.sh

