//
//  NSNumberUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSNumber+Utils.h"

@interface NSNumberUtilsTest : GRTestCase { }
@end

@implementation NSNumberUtilsTest

- (void)testHumanSize {
	long long l = 5028463290;
	NSNumber *n = [NSNumber numberWithLongLong:l];
	NSString *sizeString = [n gh_humanSize];
	GRAssertEqualStrings(sizeString, @"4.68 GB");
	
	long long maxll = 9223372036854775807; // LLONG_MAX
	NSNumber *mll = [NSNumber numberWithLongLong:maxll];
	GRAssertNotNil(mll);	
	NSString *maxllSizeString = [mll gh_humanSize];
	GRAssertEqualStrings(maxllSizeString, @"8589934592.00 GB");
	GRTestLog(@"maxllSizeString=%@", maxllSizeString);
}

- (void)testOrdinalize {
  GRAssertEqualStrings([[NSNumber numberWithInteger:1] gh_ordinalize], @"1st");
  GRAssertEqualStrings([[NSNumber numberWithInteger:2] gh_ordinalize], @"2nd");
  GRAssertEqualStrings([[NSNumber numberWithInteger:3] gh_ordinalize], @"3rd");
  GRAssertEqualStrings([[NSNumber numberWithInteger:4] gh_ordinalize], @"4th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:5] gh_ordinalize], @"5th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:6] gh_ordinalize], @"6th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:7] gh_ordinalize], @"7th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:8] gh_ordinalize], @"8th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:9] gh_ordinalize], @"9th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:10] gh_ordinalize], @"10th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:11] gh_ordinalize], @"11th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:12] gh_ordinalize], @"12th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:13] gh_ordinalize], @"13th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:14] gh_ordinalize], @"14th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:111] gh_ordinalize], @"111th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:212] gh_ordinalize], @"212th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:313] gh_ordinalize], @"313th");
  GRAssertEqualStrings([[NSNumber numberWithInteger:221] gh_ordinalize], @"221st");
  GRAssertEqualStrings([[NSNumber numberWithInteger:222] gh_ordinalize], @"222nd");
  
  GRAssertEqualStrings([NSNumber gh_ordinalize:1], @"1st");
}

@end
