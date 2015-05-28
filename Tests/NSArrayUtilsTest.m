//
//  NSArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSArrayUtilsTest : XCTestCase { }
@end


@implementation NSArrayUtilsTest

- (void)testRandom {
	NSSet *set = [NSSet setWithObjects:@"1", @"2", @"3", nil];
	
	NSString *obj = [[set allObjects] gh_randomObject];
	XCTAssertTrue([set containsObject:obj]);
}

- (void)testReversed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] gh_arrayByReversingArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
	XCTAssertEqualObjects(array, expected);
}

- (void)testSubarrayWithRange {
	NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 length
	NSArray *subarray1 = [array gh_subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected1 = [NSArray array];
	XCTAssertEqualObjects(subarray1, expected1);
		
	// Test equal length
	NSArray *subarray2 = [array gh_subarrayWithRange:NSMakeRange(0, 3)];
	XCTAssertEqualObjects(subarray2, array);
	
	// Test normal
	NSArray *subarray3 = [array gh_subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected3 = [NSArray arrayWithObjects:@"2", @"3", nil];
	XCTAssertEqualObjects(subarray3, expected3);
	
	// Test length overflow
	NSArray *subarray4 = [array gh_subarrayWithRange:NSMakeRange(1, 4)];
	NSArray *expected4 = [NSArray arrayWithObjects:@"2", @"3", nil];
	XCTAssertEqualObjects(subarray4, expected4);
	
	// Test location overflow -> nil
	NSArray *subarray5 = [array gh_subarrayWithRange:NSMakeRange(3, 0)];
	XCTAssertNil(subarray5);	
}

- (void)testSubarrayFromLocation {
  NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 position
	NSArray *subarray1 = [array gh_subarrayFromLocation:0];
	XCTAssertEqualObjects(subarray1, array);
  
	NSArray *subarray2 = [array gh_subarrayFromLocation:1];
  NSArray *expected2 = [NSArray arrayWithObjects:@"2", @"3", nil];
	XCTAssertEqualObjects(subarray2, expected2);
	
	NSArray *subarray3 = [array gh_subarrayFromLocation:2];
	NSArray *expected3 = [NSArray arrayWithObjects:@"3", nil];
	XCTAssertEqualObjects(subarray3, expected3);
	
	// Test location == count
	NSArray *subarray4 = [array gh_subarrayFromLocation:3];
	NSArray *expected4 = [NSArray array];
	XCTAssertEqualObjects(subarray4, expected4);
	
	// Test location overflow
	NSArray *subarray5 = [array gh_subarrayFromLocation:4];
	NSArray *expected5 = [NSArray array];
	XCTAssertEqualObjects(subarray5, expected5);
}

- (void)testCompact {
  NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", [NSNull null], nil] gh_compact];
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", nil];
	XCTAssertEqualObjects(array, expected);

  NSArray *array2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
  NSArray *compactArray2 = [array2 gh_compact];
	NSArray *expected2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	XCTAssertEqualObjects(compactArray2, expected2);
  XCTAssertEqual(array2, compactArray2); // Will also be ==

  NSArray *array3 = [NSArray array];
  NSArray *compactArray3 = [array3 gh_compact];
	NSArray *expected3 = [NSArray array];
	XCTAssertEqualObjects(compactArray3, expected3);
  XCTAssertEqual(array3, compactArray3); // Will also be ==

  NSArray *array4 = [NSArray arrayWithObject:[NSNull null]];
  NSArray *compactArray4 = [array4 gh_compact];
	NSArray *expected4 = [NSArray array];
	XCTAssertEqualObjects(compactArray4, expected4);
}

- (void)testObjectAtIndex {
  id value1 = [[NSArray array] gh_objectAtIndex:0 withDefault:@"default"];
  XCTAssertEqualObjects(value1, @"default");
  
  id value2 = [[NSArray array] gh_objectAtIndex:1];
  XCTAssertNil(value2);

  id value3 = [[NSArray array] gh_objectAtIndex:-1];
  XCTAssertNil(value3);

  id value4 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:0];
  XCTAssertEqualObjects(value4, @"0");

  id value5 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:1];
  XCTAssertNil(value5);

  id value6 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:-1];
  XCTAssertNil(value6);

  id value7 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:2];
  XCTAssertNil(value7);
  
  id value8 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:1];
  XCTAssertEqualObjects(value8, @"1");
}

- (void)testJSON {
  NSString *JSONString = [@[@"string", @(2), @(3.1), @YES] gh_toJSON:0 error:nil];
  XCTAssertEqualObjects(@"[\"string\",2,3.1,true]", JSONString);
}

- (void)testUniq {
  NSArray *uniq = [@[@(1), @(1), @(3)] gh_uniq];
  NSArray *expected = @[@(1), @(3)];
  XCTAssertEqualObjects(uniq, expected);
}

@end
