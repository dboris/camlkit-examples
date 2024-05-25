.PHONY: build bundle

OUTPUT := MyLibrary.xcframework
BUILD_DIR := _build

bundle: $(BUILD_DIR)/libcaml.a
	rm -rf $(OUTPUT)
	xcodebuild -create-xcframework \
		-library $(BUILD_DIR)/device.ios/libcaml.a \
		-library $(BUILD_DIR)/libcaml.a \
		-output $(OUTPUT) \
		-allow-internal-distribution

build:
	dune build @default

$(BUILD_DIR)/libcaml.a: build
	lipo $(BUILD_DIR)/simulator.ios/libcaml.a $(BUILD_DIR)/simulator-arm.ios/libcaml.a -create -output $@
