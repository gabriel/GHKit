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

@end

