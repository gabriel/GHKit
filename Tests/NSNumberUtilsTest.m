//
//  NSNumberUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSNumber+Utils.h"

@interface NSNumberUtilsTest : GHTestCase { }
@end

@implementation NSNumberUtilsTest

- (void)testHumanSize {
	long long l = 5028463290;
	NSNumber *n = [NSNumber numberWithLongLong:l];
	NSString *sizeString = [n gh_humanSize];
	GHAssertEqualStrings(sizeString, @"4.68 GB", nil);
	
	long long maxll = 9223372036854775807; // LLONG_MAX
	NSNumber *mll = [NSNumber numberWithLongLong:maxll];
	GHAssertNotNil(mll, nil);	
	NSString *maxllSizeString = [mll gh_humanSize];
	GHAssertEqualStrings(maxllSizeString, @"8589934592.00 GB", nil);
	GHTestLog(@"maxllSizeString=%@", maxllSizeString);
}

@end
