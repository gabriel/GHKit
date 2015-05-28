//
//  NSMutableDictionaryUtilsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 7/1/10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSMutableDictionaryUtilsTest : XCTestCase { }
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
  XCTAssertEqualObjects(dict, expected);
  
  NSMutableDictionary *dict2 = [@{@"key2": NSNull.null, @"key1": @"1"} mutableCopy];
  
  NSMutableDictionary *expected2 = [@{@"key1": @"1"} mutableCopy];
  [dict2 gh_mutableCompact];
  XCTAssertEqualObjects(dict2, expected2);
}

@end
