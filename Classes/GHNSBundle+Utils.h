//
//  GHNSBundle+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 4/27/09.
//  Copyright 2009. All rights reserved.
//

@interface NSBundle (GHUtils)

- (NSData *)gh_loadDataFromResource:(NSString *)resource;
- (NSString *)gh_loadStringDataFromResource:(NSString *)resource;
- (NSURL *)gh_URLForResource:(NSString *)resource;

@end
