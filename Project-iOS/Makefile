
COMMAND=xcodebuild

default:
	$(COMMAND) -target "GHKitIOS (Simulator)" -configuration Release -sdk iphonesimulator -project GHKitIOS.xcodeproj build
	$(COMMAND) -target "GHKitIOS (Device)" -configuration Release -sdk iphoneos -project GHKitIOS.xcodeproj build
	BUILD_DIR="build" BUILD_STYLE="Release" sh Scripts/CombineLibs.sh
	sh Scripts/iOSFramework.sh

# If you need to clean a specific target/configuration: $(COMMAND) -target $(TARGET) -configuration DebugOrRelease -sdk $(SDK) clean
clean:
	-rm -rf build/*

test:
	GHUNIT_CLI=1 $(COMMAND) -target Tests -configuration Debug -sdk iphonesimulator -project GHKitIOS.xcodeproj
