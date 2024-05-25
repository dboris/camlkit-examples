.PHONY: build

MyLibrary.xcframework: _build/libcaml.a
	rm -rf $@
	xcodebuild -create-xcframework -output $@ \
		-library _build/device.ios/libcaml.a \
		-library $^ \
		-allow-internal-distribution

_build/libcaml.a: build
	lipo -create -output $@ \
		_build/simulator.ios/libcaml.a \
		_build/simulator-arm.ios/libcaml.a

build:
	dune build @default
