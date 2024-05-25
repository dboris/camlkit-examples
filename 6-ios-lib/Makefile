.PHONY: all clean distclean

BUILD_DIR := dist
BUILD_DEV := _build/device.ios
BUILD_SIM := _build/simulator.ios
BUILD_LIBS := $(BUILD_DEV)/libcaml.a $(BUILD_SIM)/libcaml.a
DUNE_DEPS := main.ml stubs.c dune

all: dist/libcaml.a

$(BUILD_LIBS): $(DUNE_DEPS)
	dune build

$(BUILD_DIR):
	mkdir $@

$(BUILD_DIR)/libcaml.a: $(BUILD_LIBS) | $(BUILD_DIR)
	lipo $^ -create -output $@

$(BUILD_DIR)/libcaml.h: lib/libwrap.h | $(BUILD_DIR)
	cp $< $@

clean:
	dune clean

distclean: clean
	rm dist/*