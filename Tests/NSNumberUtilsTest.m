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

- (void)testOrdinalize {
  GHAssertEqualStrings([[NSNumber numberWithInteger:1] gh_ordinalize], @"1st", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:2] gh_ordinalize], @"2nd", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:3] gh_ordinalize], @"3rd", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:4] gh_ordinalize], @"4th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:5] gh_ordinalize], @"5th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:6] gh_ordinalize], @"6th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:7] gh_ordinalize], @"7th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:8] gh_ordinalize], @"8th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:9] gh_ordinalize], @"9th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:10] gh_ordinalize], @"10th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:11] gh_ordinalize], @"11th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:12] gh_ordinalize], @"12th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:13] gh_ordinalize], @"13th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:14] gh_ordinalize], @"14th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:111] gh_ordinalize], @"111th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:212] gh_ordinalize], @"212th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:313] gh_ordinalize], @"313th", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:221] gh_ordinalize], @"221st", nil);
  GHAssertEqualStrings([[NSNumber numberWithInteger:222] gh_ordinalize], @"222nd", nil);
  
  GHAssertEqualStrings([NSNumber gh_ordinalize:1], @"1st", nil);
}

@end
