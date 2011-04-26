//
//  NSMutableArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSMutableArray+Utils.h"

@interface NSMutableArrayUtilsTest : GHTestCase { }
@end

@implementation NSMutableArrayUtilsTest

- (void)testInsertObjectsAtIndex {
	NSArray *objects = [NSArray arrayWithObjects:@"2", @"3", nil];
	
	NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", nil];
	[array gh_insertObjects:objects atIndex:1];
	
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	GHAssertEqualObjects(array, expected, nil);	
}

- (void)testInsertObjectsAtIndexEmpty {
	NSArray *objects = [NSArray array];
	
	NSMutableArray *array = [NSMutableArray array];
	[array gh_insertObjects:objects atIndex:0];
	
	NSArray *expected = [NSArray array];
	GHAssertEqualObjects(array, expected, nil);
}	

- (void)testCompact {
  NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", [NSNull null], nil];
  [array gh_mutableCompact];
	NSMutableArray *expected = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
	GHAssertEqualObjects(array, expected, nil);
  
  NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
  [array2 gh_mutableCompact];
	NSMutableArray *expected2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
	GHAssertEqualObjects(array2, expected2, nil);
  
  NSMutableArray *array3 = [NSMutableArray array];
  [array3 gh_mutableCompact];
	NSMutableArray *expected3 = [NSMutableArray array];
	GHAssertEqualObjects(array3, expected3, nil);
  
  NSMutableArray *array4 = [NSMutableArray arrayWithObject:[NSNull null]];
  [array4 gh_mutableCompact];
	NSMutableArray *expected4 = [NSMutableArray array];
	GHAssertEqualObjects(array4, expected4, nil);
}

- (void)testAddObjectIfNotNil {
  NSMutableArray *array = [NSMutableArray array];
  [array gh_addObject:nil];
  [array gh_addObject:@"1"];
  GHAssertTrue([array count] == 1, nil);
}

- (void)testReplaceObject {
  NSUInteger index;

  NSMutableArray *emptyArray = [NSMutableArray array];
  index = [emptyArray gh_replaceObject:@"1" withObject:nil];
  GHAssertEquals(index, (NSUInteger)NSNotFound, nil);
  
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  index = [array gh_replaceObject:@"1" withObject:@"2"];
  GHAssertEquals(index, (NSUInteger)0, nil);
  NSMutableArray *expected1 = [NSMutableArray arrayWithObject:@"2"];
	GHAssertEqualObjects(array, expected1, nil);
  
  index = [array gh_replaceObject:@"1" withObject:@"3"];
  GHAssertEquals(index, (NSUInteger)NSNotFound, nil);
	GHAssertEqualObjects(array, expected1, nil);
}

- (void)testRemoveLastObject {
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  id obj = [array gh_removeLastObject];
  GHAssertEqualObjects(obj, @"1", nil);
  NSMutableArray *expected = [NSMutableArray array];
	GHAssertEqualObjects(array, expected, nil);
  GHAssertNil([array gh_removeLastObject], nil);
}

@end

