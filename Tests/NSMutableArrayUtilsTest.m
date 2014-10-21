//
//  NSMutableArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSMutableArray+Utils.h"

@interface NSMutableArrayUtilsTest : GRTestCase { }
@end

@implementation NSMutableArrayUtilsTest

- (void)testInsertObjectsAtIndex {
	NSArray *objects = [NSArray arrayWithObjects:@"2", @"3", nil];
	
	NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", nil];
	[array gh_insertObjects:objects atIndex:1];
	
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	GRAssertEqualObjects(array, expected);	
}

- (void)testInsertObjectsAtIndexEmpty {
	NSArray *objects = [NSArray array];
	
	NSMutableArray *array = [NSMutableArray array];
	[array gh_insertObjects:objects atIndex:0];
	
	NSArray *expected = [NSArray array];
	GRAssertEqualObjects(array, expected);
}	

- (void)testCompact {
  NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", [NSNull null], nil];
  [array gh_mutableCompact];
	NSMutableArray *expected = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
	GRAssertEqualObjects(array, expected);
  
  NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
  [array2 gh_mutableCompact];
	NSMutableArray *expected2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
	GRAssertEqualObjects(array2, expected2);
  
  NSMutableArray *array3 = [NSMutableArray array];
  [array3 gh_mutableCompact];
	NSMutableArray *expected3 = [NSMutableArray array];
	GRAssertEqualObjects(array3, expected3);
  
  NSMutableArray *array4 = [NSMutableArray arrayWithObject:[NSNull null]];
  [array4 gh_mutableCompact];
	NSMutableArray *expected4 = [NSMutableArray array];
	GRAssertEqualObjects(array4, expected4);
}

- (void)testAddObjectIfNotNil {
  NSMutableArray *array = [NSMutableArray array];
  [array gh_addObject:nil];
  [array gh_addObject:@"1"];
  GRAssertTrue([array count] == 1);
}

- (void)testReplaceObject {
  NSUInteger index;

  NSMutableArray *emptyArray = [NSMutableArray array];
  index = [emptyArray gh_replaceObject:@"1" withObject:nil];
  GRAssertEquals(index, (NSUInteger)NSNotFound);
  
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  index = [array gh_replaceObject:@"1" withObject:@"2"];
  GRAssertEquals(index, (NSUInteger)0);
  NSMutableArray *expected1 = [NSMutableArray arrayWithObject:@"2"];
	GRAssertEqualObjects(array, expected1);
  
  index = [array gh_replaceObject:@"1" withObject:@"3"];
  GRAssertEquals(index, (NSUInteger)NSNotFound);
	GRAssertEqualObjects(array, expected1);
}

- (void)testRemoveLastObject {
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  id obj = [array gh_removeLastObject];
  GRAssertEqualObjects(obj, @"1");
  NSMutableArray *expected = [NSMutableArray array];
	GRAssertEqualObjects(array, expected);
  GRAssertNil([array gh_removeLastObject]);
}

@end

