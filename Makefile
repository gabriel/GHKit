
COMMAND=xcodebuild

macosx:
	$(COMMAND) -target GHKit -configuration Debug -sdk macosx10.5 -project GHKit.xcodeproj

ios:
	xcodebuild -target "GHKitIPhone (Simulator)" -configuration Release -sdk iphonesimulator4.1 -project GHKitIPhone.xcodeproj build
	xcodebuild -target "GHKitIPhone (Device)" -configuration Release -sdk iphoneos4.1 -project GHKitIPhone.xcodeproj build
	BUILD_DIR="build" BUILD_STYLE="Release" sh Scripts/CombineLibs.sh
	sh Scripts/iPhoneFramework.sh

docs:
	/Applications/Doxygen.app/Contents/Resources/doxygen

# If you need to clean a specific target/configuration: $(COMMAND) -target $(TARGET) -configuration DebugOrRelease -sdk $(SDK) clean
clean:
	-rm -rf build/*

test:
	GHUNIT_AUTORUN=1 GHUNIT_AUTOEXIT=1 $(COMMAND) -target GHKitTests -configuration Debug -sdk macosx10.5 -project GHKit.xcodeproj
	
test-ios:
	GHUNIT_CLI=1 $(COMMAND) -target Tests -configuration Debug -sdk iphonesimulator4.1 -project GHKitIPhone.xcodeproj
