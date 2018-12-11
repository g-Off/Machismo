SWIFTC_FLAGS = -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.13"
CONFIGURATION = debug

debug: build

build:
	swift build --configuration $(CONFIGURATION) $(SWIFTC_FLAGS)
	
test:
	swift test $(SWIFTC_FLAGS)
	
xcode:
	swift package generate-xcodeproj --xcconfig-overrides=Overrides.xcconfig
	xed .

clean:
	swift package clean
	
.PHONY: debug build test xcode clean
