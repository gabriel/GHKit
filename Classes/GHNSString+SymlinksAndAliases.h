//
//  GHNSString+SymlinksAndAliases.h
//  Renamed from NSString+SymlinksAndAliases.h
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

/*! 
 For resolving symlinks and aliases.
 
 @code
 NSString *fullyResolvedPath = [somePath gh_stringByResolvingSymlinksAndAliases];
 @endcode 
 
 From http://cocoawithlove.com/2010/02/resolving-path-containing-mixture-of.html
 
 */
@interface NSString(GHSymlinksAndAliases)

/*!
 Tries to make a standardized, absolute path from the current string,
 resolving any aliases or symlinks in the path.
 @result Returns the fully resolved path (if possible) or nil (if resolution fails)
 */
- (NSString *)gh_stringByResolvingSymlinksAndAliases;

/*!
 Resolves the path where the final component could be a symlink and any
 component could be an alias.
 @result Returns the resolved path
 */
- (NSString *)gh_stringByIterativelyResolvingSymlinkOrAlias;

/*!
 Attempts to resolve the single alias at the end of the path.
 @result Returns the resolved alias or self if path wasn't an alias or couldn't 
 resolved.
 */
- (NSString *)gh_stringByResolvingAlias;

/*!
 Attempts to resolve the single symlink at the end of the path.
 @result Returns the resolved path or self if path wasn't a symlink or couldn't be
 resolved.
 */
- (NSString *)gh_stringByResolvingSymlink;

/*!
 Attempt to resolve the symlink pointed to by the path.
 @result Returns the resolved path (if it was a symlink and resolution is possible) otherwise nil
 */
- (NSString *)gh_stringByConditionallyResolvingSymlink;

/*!
 Attempt to resolve the alias pointed to by the path.
 @result Returns the resolved path (if it was an alias and resolution is possible) otherwise nil
 */
- (NSString *)gh_stringByConditionallyResolvingAlias;

@end
