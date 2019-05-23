PROJECT = galois.system
MODEL = TestHarness
CFG_PROJECT = myconfig
CONFIG = MyConfig

CFG_FULL = $(CFG_PROJECT).$(CONFIG)

all: build/$(CFG_PROJECT).$(CONFIG).v

build:
	mkdir $@

build/$(CFG_FULL).fir: build.sbt $(CFG_PROJECT).scala | build
	sbt "runMain galois.system.Generator build $(PROJECT) $(MODEL) $(CFG_PROJECT) $(CONFIG)"

FIRRTL_OPTS = \
	-X verilog \
	--infer-rw $(MODEL) \
	--repl-seq-mem \
	-c:$(MODEL):-o:build/$(CFG_FULL).conf \
	-faf build/$(CFG_FULL).anno.json \
	-td build/$(CFG_FULL)/


build/$(CFG_FULL).v: build/$(CFG_FULL).fir
	sbt "runMain firrtl.Driver -i $< -o $@ $(FIRRTL_OPTS)"
