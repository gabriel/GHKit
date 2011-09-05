# GHKit

The GHKit framework is a set of extensions and utilities for Mac OS X and iOS.

For documentation see [http://gabriel.github.com/gh-kit/](http://gabriel.github.com/gh-kit/)

## Install (Docset)

- Open Xcode, Preferences and select the Documentation tab.
- Select the plus icon (bottom left) and specify: `http://gabriel.github.com/gh-kit/publish/me.rel.GHKit.atom`

## Install (Mac OS X)

- Copy `GHKit.framework` to your project directory (maybe in `MyProject/Frameworks/.`)
- Add the `GHKit.framekwork` (from `MyProject/Frameworks/`) to the your target. It should now be visible as a `Linked Framework` in the target.
- Under `Build Settings`, add `@loader_path/../Frameworks` to `Runpath Search Paths`
- Add `New Build Phase` | `New Copy Files Build Phase`. 
	- Change the `Destination` to `Frameworks`.
	- Drag `GHKit.framework` into the the build phase
	- Make sure the copy phase appears before any `Run Script` phases


## Install (iOS)

- Add the `GHKitIOS.framework` to your project.
- Add the following frameworks to `Linked Libraries`:
  - `GHKitIOS.framework`
  - `CoreGraphics.framework`
  - `Foundation.framework`
  - `UIKit.framework`
- Under 'Framework Search Paths' make sure the (parent) directory to GHKitIOS.framework is listed.
- Under 'Other Linker Flags' in your target, add `-ObjC` and `-all_load`


## Building (iOS)

To build, go to Project-iOS and run `make`. The framework will be in `build/Framework/`.

