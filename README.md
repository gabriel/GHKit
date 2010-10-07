# GHKit

The GHKit framework is a set of extensions and utilities for Mac OS X and iOS.

## Download

See Downloads.

## Docset

Download and install to docset to `~/Library/Developer/Shared/Documentation/DocSets/GHKit.docset`

The documentation will appear within XCode:

![GHKit-Docset](http://rel.me.s3.amazonaws.com/gh-kit/images/docset.png)

## Installation

There are a few options. You can install it globally in `/Library/Frameworks` or with a little extra effort embed it with your project.

### Installing in /Library/Frameworks

- Copy `GHKit.framework` to `/Library/Frameworks/`
- In the `Target Info` window, `General` tab:
	- Add a linked library, under `Mac OS X 10.5 SDK` section, select `GHKit.framework`

### Installing in your project

- Copy `GHKit.framework` to your project directory (maybe in `MyProject/Frameworks/.`)
- Add the `GHKit.framekwork` (from `MyProject/Frameworks/`) to the your target. It should now be visible as a `Linked Framework` in the target. 
- Under `Build Settings`, add `@loader_path/../Frameworks` to `Runpath Search Paths`
- Add `New Build Phase` | `New Copy Files Build Phase`. 
	- Change the `Destination` to `Frameworks`.
	- Drag `GHKit.framework` into the the build phase
	- Make sure the copy phase appears before any `Run Script` phases 

To use the framework:

	#import <GHKit/GHKit.h>

## Install (iOS)

- Add the `GHKitIOS.framework` to your project.
- Add the following frameworks to `Linked Libraries`:
  - `GHKitIOS.framework`
  - `CoreGraphics.framework`
  - `Foundation.framework`
  - `UIKit.framework`
- Under 'Framework Search Paths' make sure the (parent) directory to GHKitIOS.framework is listed.
- Under 'Other Linker Flags' in the `Test` target, add `-ObjC` and `-all_load`

To use the framework:

	#import <GHKitIOS/GHKitIOS.h>

## Building (iOS)

To build, run `make ios`. The framework will be in `build/Framework/`.

