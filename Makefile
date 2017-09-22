CRYSTAL ?= crystal
CRFLAGS += --release

all: bin/c2cr

bin/c2cr: samples/c2cr.cr samples/c2cr/*.cr src/*.cr src/lib_clang/*.cr
	@mkdir -p bin
	$(CRYSTAL) build $(CRFLAGS) samples/c2cr.cr -o bin/c2cr
