//
//  NSMutableArrayUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSMutableArrayUtilsTest : XCTestCase { }
@end

@implementation NSMutableArrayUtilsTest

- (void)testInsertObjectsAtIndex {
	NSArray *objects = [NSArray arrayWithObjects:@"2", @"3", nil];
	
	NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", nil];
	[array gh_insertObjects:objects atIndex:1];
	
	NSArray *expected = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	XCTAssertEqualObjects(array, expected);	
}

- (void)testInsertObjectsAtIndexEmpty {
	NSArray *objects = [NSArray array];
	
	NSMutableArray *array = [NSMutableArray array];
	[array gh_insertObjects:objects atIndex:0];
	
	NSArray *expected = [NSArray array];
	XCTAssertEqualObjects(array, expected);
}	

- (void)testCompact {
  NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", [NSNull null], nil];
  [array gh_mutableCompact];
	NSMutableArray *expected = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
	XCTAssertEqualObjects(array, expected);
  
  NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
  [array2 gh_mutableCompact];
	NSMutableArray *expected2 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
	XCTAssertEqualObjects(array2, expected2);
  
  NSMutableArray *array3 = [NSMutableArray array];
  [array3 gh_mutableCompact];
	NSMutableArray *expected3 = [NSMutableArray array];
	XCTAssertEqualObjects(array3, expected3);
  
  NSMutableArray *array4 = [NSMutableArray arrayWithObject:[NSNull null]];
  [array4 gh_mutableCompact];
	NSMutableArray *expected4 = [NSMutableArray array];
	XCTAssertEqualObjects(array4, expected4);
}

- (void)testAddObjectIfNotNil {
  NSMutableArray *array = [NSMutableArray array];
  [array gh_addObject:nil];
  [array gh_addObject:@"1"];
  XCTAssertTrue([array count] == 1);
}

- (void)testReplaceObject {
  NSUInteger index;

  NSMutableArray *emptyArray = [NSMutableArray array];
  index = [emptyArray gh_replaceObject:@"1" withObject:nil];
  XCTAssertEqual(index, (NSUInteger)NSNotFound);
  
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  index = [array gh_replaceObject:@"1" withObject:@"2"];
  XCTAssertEqual(index, (NSUInteger)0);
  NSMutableArray *expected1 = [NSMutableArray arrayWithObject:@"2"];
	XCTAssertEqualObjects(array, expected1);
  
  index = [array gh_replaceObject:@"1" withObject:@"3"];
  XCTAssertEqual(index, (NSUInteger)NSNotFound);
	XCTAssertEqualObjects(array, expected1);
}

- (void)testRemoveLastObject {
  NSMutableArray *array = [NSMutableArray arrayWithObject:@"1"];
  id obj = [array gh_removeLastObject];
  XCTAssertEqualObjects(obj, @"1");
  NSMutableArray *expected = [NSMutableArray array];
	XCTAssertEqualObjects(array, expected);
  XCTAssertNil([array gh_removeLastObject]);
}

@end

