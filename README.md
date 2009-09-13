## Download

[GHKit-0.3.12.zip](http://rel.me.s3.amazonaws.com/gh-kit/GHKit-0.3.12.zip) GHKit.framework (2009/09/12)

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

### Installing as a Static Library (iPhone)

Coming Soon!