//
//  NSArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSArray+Utils.h"

@interface NSArrayUtilsTest : GRTestCase { }
@end


@implementation NSArrayUtilsTest

- (void)testRandom {
	NSSet *set = [NSSet setWithObjects:@"1", @"2", @"3", nil];
	
	NSString *obj = [[set allObjects] gh_randomObject];
	GRAssertTrue([set containsObject:obj]);
}

- (void)testReversed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] gh_arrayByReversingArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
	GRAssertEqualObjects(array, expected);
}

- (void)testSubarrayWithRange {
	NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 length
	NSArray *subarray1 = [array gh_subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected1 = [NSArray array];
	GRAssertEqualObjects(subarray1, expected1);
		
	// Test equal length
	NSArray *subarray2 = [array gh_subarrayWithRange:NSMakeRange(0, 3)];
	GRAssertEqualObjects(subarray2, array);
	
	// Test normal
	NSArray *subarray3 = [array gh_subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected3 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GRAssertEqualObjects(subarray3, expected3);
	
	// Test length overflow
	NSArray *subarray4 = [array gh_subarrayWithRange:NSMakeRange(1, 4)];
	NSArray *expected4 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GRAssertEqualObjects(subarray4, expected4);
	
	// Test location overflow -> nil
	NSArray *subarray5 = [array gh_subarrayWithRange:NSMakeRange(3, 0)];
	GRAssertNil(subarray5);	
}

- (void)testSubarrayFromLocation {
  NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 position
	NSArray *subarray1 = [array gh_subarrayFromLocation:0];
	GRAssertEqualObjects(subarray1, array);
  
	NSArray *subarray2 = [array gh_subarrayFromLocation:1];
  NSArray *expected2 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GRAssertEqualObjects(subarray2, expected2);
	
	NSArray *subarray3 = [array gh_subarrayFromLocation:2];
	NSArray *expected3 = [NSArray arrayWithObjects:@"3", nil];
	GRAssertEqualObjects(subarray3, expected3);
	
	// Test location == count
	NSArray *subarray4 = [array gh_subarrayFromLocation:3];
	NSArray *expected4 = [NSArray array];
	GRAssertEqualObjects(subarray4, expected4);
	
	// Test location overflow
	NSArray *subarray5 = [array gh_subarrayFromLocation:4];
	NSArray *expected5 = [NSArray array];
	GRAssertEqualObjects(subarray5, expected5);
}

- (void)testCompact {
  NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", [NSNull null], nil] gh_compact];
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", nil];
	GRAssertEqualObjects(array, expected);

  NSArray *array2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
  NSArray *compactArray2 = [array2 gh_compact];
	NSArray *expected2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	GRAssertEqualObjects(compactArray2, expected2);
  GRAssertEquals(array2, compactArray2); // Will also be ==

  NSArray *array3 = [NSArray array];
  NSArray *compactArray3 = [array3 gh_compact];
	NSArray *expected3 = [NSArray array];
	GRAssertEqualObjects(compactArray3, expected3);
  GRAssertEquals(array3, compactArray3); // Will also be ==

  NSArray *array4 = [NSArray arrayWithObject:[NSNull null]];
  NSArray *compactArray4 = [array4 gh_compact];
	NSArray *expected4 = [NSArray array];
	GRAssertEqualObjects(compactArray4, expected4);
}

- (void)testObjectAtIndex {
  id value1 = [[NSArray array] gh_objectAtIndex:0 withDefault:@"default"];
  GRAssertEqualStrings(value1, @"default");
  
  id value2 = [[NSArray array] gh_objectAtIndex:1];
  GRAssertNil(value2);

  id value3 = [[NSArray array] gh_objectAtIndex:-1];
  GRAssertNil(value3);

  id value4 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:0];
  GRAssertEqualStrings(value4, @"0");

  id value5 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:1];
  GRAssertNil(value5);

  id value6 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:-1];
  GRAssertNil(value6);

  id value7 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:2];
  GRAssertNil(value7);
  
  id value8 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:1];
  GRAssertEqualStrings(value8, @"1");
}

- (void)testJSON {
  NSString *JSONString = [@[@"string", @(2), @(3.1), @YES] gh_toJSONString:nil];
  GRAssertEqualStrings(@"[\"string\",2,3.1,true]", JSONString);
}

- (void)testUniq {
  NSArray *uniq = [@[@(1), @(1), @(3)] gh_uniq];
  NSArray *expected = @[@(1), @(3)];
  GRAssertEqualObjects(uniq, expected);
}

@end
