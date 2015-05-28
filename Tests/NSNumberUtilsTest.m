//
//  NSNumberUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSNumberUtilsTest : XCTestCase { }
@end

@implementation NSNumberUtilsTest

- (void)testHumanSize {
	long long l = 5028463290;
	NSNumber *n = [NSNumber numberWithLongLong:l];
	NSString *sizeString = [n gh_humanSize];
	XCTAssertEqualObjects(sizeString, @"4.68 GB");
	
	long long maxll = 9223372036854775807; // LLONG_MAX
	NSNumber *mll = [NSNumber numberWithLongLong:maxll];
	XCTAssertNotNil(mll);	
	NSString *maxllSizeString = [mll gh_humanSize];
	XCTAssertEqualObjects(maxllSizeString, @"8589934592.00 GB");
	NSLog(@"maxllSizeString=%@", maxllSizeString);
}

- (void)testOrdinalize {
  XCTAssertEqualObjects([[NSNumber numberWithInteger:1] gh_ordinalize], @"1st");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:2] gh_ordinalize], @"2nd");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:3] gh_ordinalize], @"3rd");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:4] gh_ordinalize], @"4th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:5] gh_ordinalize], @"5th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:6] gh_ordinalize], @"6th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:7] gh_ordinalize], @"7th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:8] gh_ordinalize], @"8th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:9] gh_ordinalize], @"9th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:10] gh_ordinalize], @"10th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:11] gh_ordinalize], @"11th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:12] gh_ordinalize], @"12th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:13] gh_ordinalize], @"13th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:14] gh_ordinalize], @"14th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:111] gh_ordinalize], @"111th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:212] gh_ordinalize], @"212th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:313] gh_ordinalize], @"313th");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:221] gh_ordinalize], @"221st");
  XCTAssertEqualObjects([[NSNumber numberWithInteger:222] gh_ordinalize], @"222nd");
  
  XCTAssertEqualObjects([NSNumber gh_ordinalize:1], @"1st");
}

@end
