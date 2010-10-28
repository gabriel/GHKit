
COMMAND=xcodebuild

macosx:
	$(COMMAND) -target GHKit -configuration Debug -sdk macosx10.5 -project GHKit.xcodeproj

ios:
	$(COMMAND) -target "GHKitIPhone (Simulator)" -configuration Release -sdk iphonesimulator4.1 -project GHKitIPhone.xcodeproj build
	$(COMMAND) -target "GHKitIPhone (Device)" -configuration Release -sdk iphoneos4.1 -project GHKitIPhone.xcodeproj build
	BUILD_DIR="build" BUILD_STYLE="Release" sh Scripts/CombineLibs.sh
	sh Scripts/iPhoneFramework.sh

docs:
	/Applications/Doxygen.app/Contents/Resources/doxygen
	# TODO(gabe): Get doxyclean working
	cd Documentation/html && make install
	cd ~/Library/Developer/Shared/Documentation/DocSets/ && tar zcvpf GHKit.docset.tgz GHKit.docset
	mv ~/Library/Developer/Shared/Documentation/DocSets/GHKit.docset.tgz Documentation

docs-gh: docs
	rm -rf build
	git checkout gh-pages
	cp -R Documentation/html/* .
	rm -rf Documentation
	git add .
	git commit -a -m 'Updating docs' && git push origin gh-pages
	git checkout master

# If you need to clean a specific target/configuration: $(COMMAND) -target $(TARGET) -configuration DebugOrRelease -sdk $(SDK) clean
clean:
	-rm -rf build/*

test:
	GHUNIT_AUTORUN=1 GHUNIT_AUTOEXIT=1 $(COMMAND) -target GHKitTests -configuration Debug -sdk macosx10.5 -project GHKit.xcodeproj
	
test-ios:
	GHUNIT_CLI=1 $(COMMAND) -target Tests -configuration Debug -sdk iphonesimulator4.1 -project GHKitIPhone.xcodeproj
