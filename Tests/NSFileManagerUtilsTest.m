//
//  NSFileManager+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 3/9/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSFileManager+Utils.h"

@interface NSFileManagerUtilsTest : GRTestCase { }
@end


@implementation NSFileManagerUtilsTest

- (void)testEnsureDirectory {
	NSError *error = nil;
	NSString *path = [NSFileManager gh_temporaryFile:nil deleteIfExists:YES error:&error];
	if (error) GRFail(@"Error: %@", error);
	BOOL success = [NSFileManager gh_ensureDirectoryExists:path created:nil error:&error];
	if (error) GRFail(@"Error: %@", error);
	GRAssertTrue(success);
}

- (void)testFileSize {
  NSString *path = [NSFileManager gh_pathToResource:@"test.file"];
  GRAssertTrue([NSFileManager gh_exist:path]);
  NSNumber *fileSize = [NSFileManager gh_fileSize:path error:nil];
  GRAssertEquals([fileSize longValue], 10L);
}

@end
