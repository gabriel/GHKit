
COMMAND=xcodebuild

default:
	$(COMMAND) -target GHKit -configuration Release -sdk macosx -project GHKit.xcodeproj

# If you need to clean a specific target/configuration: $(COMMAND) -target $(TARGET) -configuration DebugOrRelease -sdk $(SDK) clean
clean:
	-rm -rf build/*

test:
	GHUNIT_AUTORUN=1 GHUNIT_AUTOEXIT=1 $(COMMAND) -target GHKitTests -configuration Debug -sdk macosx -project GHKit.xcodeproj
