//
//  NSDictionaryNSNullTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSDictionary+NSNull.h"

@interface NSDictionaryNSNullTest : GHTestCase { }
@end

@implementation NSDictionaryNSNullTest

- (void)testNilValues {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", @"value2",  @"key2", [NSNull null], @"key3", nil];	
	GHAssertEqualObjects(dict, expected, nil);
}

- (void)testPrematureNilKeyDoesntCrash {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, nil, @"", @"", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", nil];	
	GHAssertEqualObjects(dict, expected, nil);
}

//- (void)testValueForKey {
//	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
//	id value = [dict valueForKey:@"key1"];
//	GHAssertNil(value, @"Should handle in KVC");
//}

- (void)testEmpty {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:nil];
	NSDictionary *expected = [NSDictionary dictionary];	
	GHAssertEqualObjects(dict, expected, nil);	
}

- (NSDictionary *)_testVAList:(id)obj keysAndObjects:(id)firstKey, ... {
	va_list args;
  va_start(args, firstKey);
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:firstKey args:args];
	va_end(args);
	return dict;
}

- (void)testVAList {
	NSDictionary *dict = [self _testVAList:nil keysAndObjects:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
	NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], @"key1", @"value2",  @"key2", [NSNull null], @"key3", nil];	
	GHAssertEqualObjects(dict, expected, nil);
}

@end
