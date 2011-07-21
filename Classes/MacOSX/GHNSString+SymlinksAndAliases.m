//
//  GHNSString+SymlinksAndAliases.m
//  Renamed from NSString+SymlinksAndAliases.m
//
//  Created by Matt Gallagher on 2010/02/22.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "GHNSString+SymlinksAndAliases.h"
#include <sys/stat.h>

@implementation NSString(GHSymlinksAndAliases)

- (NSString *)gh_stringByResolvingSymlinksAndAliases {
	//
	// Convert to a standardized absolute path.
	//
	NSString *path = [self stringByStandardizingPath];
	if (![path hasPrefix:@"/"]) {
		return nil;
	}
	
	//
	// Break into components. First component ("/") needs no resolution, so
	// we only need to handle subsequent components.
	//
	NSArray *pathComponents = [path pathComponents];
	NSString *resolvedPath = [pathComponents objectAtIndex:0];
	pathComponents = [pathComponents
                    subarrayWithRange:NSMakeRange(1, [pathComponents count] - 1)];
  
	//
	// Process all remaining components.
	//
	for (NSString *component in pathComponents)
	{
		resolvedPath = [resolvedPath stringByAppendingPathComponent:component];
		resolvedPath = [resolvedPath gh_stringByIterativelyResolvingSymlinkOrAlias];
		if (!resolvedPath)
		{
			return nil;
		}
	}
  
	return resolvedPath;
}

- (NSString *)gh_stringByIterativelyResolvingSymlinkOrAlias {
	NSString *path = self;
	NSString *aliasTarget = nil;
	struct stat fileInfo;
	
	//
	// Use lstat to determine if the file is a symlink
	//
	if (lstat([[NSFileManager defaultManager]
             fileSystemRepresentationWithPath:path], &fileInfo) < 0) {
		return nil;
	}
	
	//
	// While the file is a symlink or we can resolve aliases in the path,
	// keep resolving.
	//
	while (S_ISLNK(fileInfo.st_mode) ||
         (!S_ISDIR(fileInfo.st_mode) &&
          (aliasTarget = [path gh_stringByConditionallyResolvingAlias]) != nil)) {
		if (S_ISLNK(fileInfo.st_mode)) {
			//
			// Resolve the symlink final component in the path
			//
			NSString *symlinkPath = [path gh_stringByConditionallyResolvingSymlink];
			if (!symlinkPath) {
				return nil;
			}
			path = symlinkPath;
		} else {
			path = aliasTarget;
		}
    
		//
		// Use lstat to determine if the file is a symlink
		//
		if (lstat([[NSFileManager defaultManager]
               fileSystemRepresentationWithPath:path], &fileInfo) < 0) {
			path = nil;
			continue;
		}
	}
	
	return path;
}

- (NSString *)gh_stringByResolvingAlias {
	NSString *aliasTarget = [self gh_stringByConditionallyResolvingAlias];
	if (aliasTarget) {
		return aliasTarget;
	}
	return self;
}

- (NSString *)gh_stringByResolvingSymlink {
	NSString *symlinkTarget = [self gh_stringByConditionallyResolvingSymlink];
	if (symlinkTarget) {
		return symlinkTarget;
	}
	return self;
}

- (NSString *)gh_stringByConditionallyResolvingSymlink {
	//
	// Resolve the symlink final component in the path
	//
	NSString *symlinkPath =
  [[NSFileManager defaultManager]
   destinationOfSymbolicLinkAtPath:self
   error:NULL];
	if (!symlinkPath) {
		return nil;
	}
	if (![symlinkPath hasPrefix:@"/"]) {
		//
		// For relative path symlinks (common case), remove the
		// relative links
		//
		symlinkPath =
    [[self stringByDeletingLastPathComponent]
     stringByAppendingPathComponent:symlinkPath];
		symlinkPath = [symlinkPath stringByStandardizingPath];
	}
	return symlinkPath;
}

- (NSString *)gh_stringByConditionallyResolvingAlias {
	NSString *resolvedPath = nil;
  
	CFURLRef url = CFURLCreateWithFileSystemPath
  (kCFAllocatorDefault, (CFStringRef)self, kCFURLPOSIXPathStyle, NO);
	if (url != NULL)
	{
		FSRef fsRef;
		if (CFURLGetFSRef(url, &fsRef))
		{
			Boolean targetIsFolder, wasAliased;
			OSErr err = FSResolveAliasFileWithMountFlags(
                                                   &fsRef, false, &targetIsFolder, &wasAliased, kResolveAliasFileNoUI);
			if ((err == noErr) && wasAliased)
			{
				CFURLRef resolvedUrl = CFURLCreateFromFSRef(kCFAllocatorDefault, &fsRef);
				if (resolvedUrl != NULL)
				{
					resolvedPath =
          [(id)CFURLCopyFileSystemPath(resolvedUrl, kCFURLPOSIXPathStyle)
           autorelease];
					CFRelease(resolvedUrl);
				}
			}
		}
		CFRelease(url);
	}
  
	return resolvedPath;
}

@end
