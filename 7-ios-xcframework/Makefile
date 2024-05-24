.PHONY: build bundle

OUTPUT := MyLibrary.xcframework

bundle: build
	rm -rf $(OUTPUT)
	xcodebuild -create-xcframework \
		-library _build/device.ios/libcaml.a \
		-library _build/simulator.ios/libcaml.a \
		-library _build/simulator-arm.ios/libcaml.a \
		-output $(OUTPUT) \
		-allow-internal-distribution

build:
	dune build @default
