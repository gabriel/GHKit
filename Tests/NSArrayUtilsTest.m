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
	[[NSArray arrayWithObjects:@"1", @"2", @"3", nil] gh_randomObject:0];
}

- (void)testReveresed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] gh_arrayByReversingArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
	GHAssertEqualObjects(array, expected, nil);
}

@end
