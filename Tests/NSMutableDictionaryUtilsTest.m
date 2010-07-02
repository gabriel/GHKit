//
//  NSMutableDictionaryUtilsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 7/1/10.
//  Copyright 2010. All rights reserved.
//

#import "GHNSMutableDictionary+Utils.h"

@interface NSMutableDictionaryUtilsTest : GHTestCase { }
@end

@implementation NSMutableDictionaryUtilsTest

- (void)testMutableCompact {
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"1", @"key1",
                               [NSNull null], @"key2", 
                               nil];

  NSMutableDictionary *expected = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"1", @"key1",
                                   nil];
  
	[dict gh_mutableCompact];
  GHAssertEqualObjects(dict, expected, nil);
}

@end
