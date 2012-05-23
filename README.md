GHKit
========

The GHKit framework is a set of extensions and utilities for Mac OS X and iOS.


Install
-------

GHKit assumes that you are using a modern Xcode project building to the DerivedData directory. Confirm your settings
via the "File" menu > "Project Settings...". On the "Build" tab within the sheet that opens, click the "Advanced..."
button and confirm that your "Build Location" is the "Derived Data Location".

1. Add Git submodule to your project: `git submodule add git://github.com/gabriel/gh-kit.git GHKit`
1. Add cross-project reference by dragging **GHKit.xcodeproj** to your project
1. Open build settings editor for your project
1. Add the following **Header Search Paths** (including the quotes): `"$(BUILT_PRODUCTS_DIR)/../../Headers"`
1. Add **Other Linker Flags** for `-ObjC -all_load`
1. Open target settings editor for the target you want to link GHKit into
1. Add direct dependency on the **GHKit** aggregate target
1. Link against GHKit:
    1. **libGHKit.a** on iOS
    1. **GHKit.framework** on OS X
1. Import the GHKit headers via `#import <GHKit/GHKit.h>`
1. Build the project to verify installation is successful.


Install (Docset)
----------------

- Open Xcode, Preferences and select the Downloads / Documentation tab.
- Select the plus icon (bottom left) and specify: `http://gabriel.github.com/gh-kit/publish/me.rel.GHKit.atom`

Documentation
--------

[API Docs](http://gabriel.github.com/gh-kit/)
