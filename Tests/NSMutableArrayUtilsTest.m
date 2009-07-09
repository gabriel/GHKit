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

@end

