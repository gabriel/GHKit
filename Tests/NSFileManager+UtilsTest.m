//
//  NSFileManager+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 3/9/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSFileManager+Utils.h"

@interface NSFileManagerUtilsTest : GHTestCase { }
@end


@implementation NSFileManagerUtilsTest

- (void)testEnsureDirectory {
	NSError *error = nil;
	NSString *path = [NSFileManager gh_temporaryFile:nil deleteIfExists:YES error:error];
	if (error) GHFail(@"Error: %@", error);
	BOOL success = [NSFileManager gh_ensureDirectoryExists:path created:nil error:error];
	if (error) GHFail(@"Error: %@", error);
	GHAssertTrue(success, nil);
}

@end
