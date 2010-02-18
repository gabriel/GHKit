//
//  NSArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/9/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSArray+Utils.h"

@interface NSArrayUtilsTest : GHTestCase { }
@end


@implementation NSArrayUtilsTest

- (void)testRandom {
	NSSet *set = [NSSet setWithObjects:@"1", @"2", @"3", nil];
	
	NSString *obj = [[set allObjects] gh_randomObject:0];
	GHAssertTrue([set containsObject:obj], nil);
}

- (void)testReversed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] gh_arrayByReversingArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
	GHAssertEqualObjects(array, expected, nil);
}

- (void)testSubarrayWithRange {
	NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 length
	NSArray *subarray1 = [array gh_subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected1 = [NSArray array];
	GHAssertEqualObjects(subarray1, expected1, nil);
		
	// Test equal length
	NSArray *subarray2 = [array gh_subarrayWithRange:NSMakeRange(0, 3)];
	GHAssertEqualObjects(subarray2, array, nil);
	
	// Test normal
	NSArray *subarray3 = [array gh_subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected3 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GHAssertEqualObjects(subarray3, expected3, nil);
	
	// Test length overflow
	NSArray *subarray4 = [array gh_subarrayWithRange:NSMakeRange(1, 4)];
	NSArray *expected4 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GHAssertEqualObjects(subarray4, expected4, nil);
	
	// Test location overflow -> nil
	NSArray *subarray5 = [array gh_subarrayWithRange:NSMakeRange(3, 0)];
	GHAssertNil(subarray5, nil);	
}

- (void)testSubarrayFromLocation {
  NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	
	// Test 0 position
	NSArray *subarray1 = [array gh_subarrayFromLocation:0];
	GHAssertEqualObjects(subarray1, array, nil);
  
	NSArray *subarray2 = [array gh_subarrayFromLocation:1];
  NSArray *expected2 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GHAssertEqualObjects(subarray2, expected2, nil);
	
	NSArray *subarray3 = [array gh_subarrayFromLocation:2];
	NSArray *expected3 = [NSArray arrayWithObjects:@"3", nil];
	GHAssertEqualObjects(subarray3, expected3, nil);
	
	// Test location == count
	NSArray *subarray4 = [array gh_subarrayFromLocation:3];
	NSArray *expected4 = [NSArray array];
	GHAssertEqualObjects(subarray4, expected4, nil);
	
	// Test location overflow
	NSArray *subarray5 = [array gh_subarrayFromLocation:4];
	NSArray *expected5 = [NSArray array];
	GHAssertEqualObjects(subarray5, expected5, nil);
}

- (void)testCompact {
  NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", [NSNull null], nil] gh_compact];
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", nil];
	GHAssertEqualObjects(array, expected, nil);

  NSArray *array2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
  NSArray *compactArray2 = [array2 gh_compact];
	NSArray *expected2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	GHAssertEqualObjects(compactArray2, expected2, nil);
  GHAssertEquals(array2, compactArray2, nil); // Will also be ==

  NSArray *array3 = [NSArray array];
  NSArray *compactArray3 = [array3 gh_compact];
	NSArray *expected3 = [NSArray array];
	GHAssertEqualObjects(compactArray3, expected3, nil);
  GHAssertEquals(array3, compactArray3, nil); // Will also be ==

  NSArray *array4 = [NSArray arrayWithObject:[NSNull null]];
  NSArray *compactArray4 = [array4 gh_compact];
	NSArray *expected4 = [NSArray array];
	GHAssertEqualObjects(compactArray4, expected4, nil);
}

- (void)testObjectAtIndex {
  id value1 = [[NSArray array] gh_objectAtIndex:0 withDefault:@"default"];
  GHAssertEqualStrings(value1, @"default", nil);
  
  id value2 = [[NSArray array] gh_objectAtIndex:1];
  GHAssertNil(value2, nil);

  id value3 = [[NSArray array] gh_objectAtIndex:-1];
  GHAssertNil(value3, nil);

  id value4 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:0];
  GHAssertEqualStrings(value4, @"0", nil);

  id value5 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:1];
  GHAssertNil(value5, nil);

  id value6 = [[NSArray arrayWithObject:@"0"] gh_objectAtIndex:-1];
  GHAssertNil(value6, nil);

  id value7 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:2];
  GHAssertNil(value7, nil);
  
  id value8 = [[NSArray arrayWithObjects:@"0", @"1", nil] gh_objectAtIndex:1];
  GHAssertEqualStrings(value8, @"1", nil);
}

@end
