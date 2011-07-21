
COMMAND=xcodebuild

default:
	$(COMMAND) -target "GHKitIOS (Simulator)" -configuration Release -sdk iphonesimulator -project GHKitIOS.xcodeproj build
	$(COMMAND) -target "GHKitIOS (Device)" -configuration Release -sdk iphoneos -project GHKitIOS.xcodeproj build
	BUILD_DIR="build" BUILD_STYLE="Release" sh Scripts/CombineLibs.sh
	sh Scripts/iOSFramework.sh

docs:
	/Applications/Doxygen.app/Contents/Resources/doxygen ../Doxyfile
	# TODO(gabe): Get doxyclean working
	cd ../Documentation/html && make install
	cd ~/Library/Developer/Shared/Documentation/DocSets/ && tar zcvpf GHKit.docset.tgz GHKit.docset
	mv ~/Library/Developer/Shared/Documentation/DocSets/GHKit.docset.tgz Documentation

gh-pages: docs
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
	GHUNIT_CLI=1 $(COMMAND) -target Tests -configuration Debug -sdk iphonesimulator -project GHKitIOS.xcodeproj
