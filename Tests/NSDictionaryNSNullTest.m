//
//  NSDictionaryNSNullTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSDictionaryNSNullTest : XCTestCase { }
@end

@implementation NSDictionaryNSNullTest

- (void)testNilValues {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", @"value2",  @"key2", [NSNull null], @"key3", nil];	
	XCTAssertEqualObjects(dict, expected);
}

- (void)testPrematureNilKeyDoesntCrash {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, nil, @"", @"", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", nil];	
	XCTAssertEqualObjects(dict, expected);
}

//- (void)testValueForKey {
//	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
//	id value = [dict valueForKey:@"key1"];
//	XCTAssertNil(value, @"Should handle in KVC");
//}

- (void)testEmpty {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:nil];
	NSDictionary *expected = [NSDictionary dictionary];	
	XCTAssertEqualObjects(dict, expected);	
}

- (NSDictionary *)_testVAList:(id)obj ignoreNil:(BOOL)ignoreNil keysAndObjects:(id)firstKey, ... {
	va_list args;
  va_start(args, firstKey);
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:firstKey args:args ignoreNil:ignoreNil];
	va_end(args);
	return dict;
}

- (void)testVAList {
	NSDictionary *dict = [self _testVAList:nil ignoreNil:NO keysAndObjects:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", @"value2",  @"key2", [NSNull null], @"key3", nil];	
	XCTAssertEqualObjects(dict, expected);
  
  NSDictionary *dict2 = [self _testVAList:nil ignoreNil:YES keysAndObjects:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
	NSDictionary *expected2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value2",  @"key2", nil];	
	XCTAssertEqualObjects(dict2, expected2);

}

@end
