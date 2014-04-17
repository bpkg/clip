
BIN ?= clip
PREFIX ?= /usr/local

export CLIP_FILE ?= ./.test_clip

install:
	cp $(BIN).sh $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)

test:
	./test.sh

