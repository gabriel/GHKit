//
//  NSDictionaryUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 6/4/09.
//  Copyright 2009. All rights reserved.
//


#import "GHNSDictionary+Utils.h"

@interface NSDictionaryUtilsTest : GHTestCase { }
@end

@implementation NSDictionaryUtilsTest

- (void)testBoolValue {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
												[NSNumber numberWithBool:YES], @"key2", 
												[NSNumber numberWithBool:NO], @"key3", 
												[NSNull null], @"key4", 
												nil];
	
	GHAssertTrue([[dict gh_boolValueForKey:@"key1"] boolValue], nil);
	GHAssertTrue([[dict gh_boolValueForKey:@"key2"] boolValue], nil);
	GHAssertFalse([[dict gh_boolValueForKey:@"key3"] boolValue], nil);
	GHAssertFalse([[dict gh_boolValueForKey:@"key4"] boolValue], nil);
}

- (void)testDataValue {
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"hwLWnp0tXoCzs+W0UdVPUaBSfiW1Q5B9m6xzDPFXvJqpqXvk1nnmMBNziXJWE4M823j8oSRl0uLhCAhxJW6ah7/a25DjGzwa", @"key1",
                        nil];
  NSData *data = [dict gh_dataAsBase64ForKey:@"key1" options:0];
  NSData *expected = [[NSData alloc] initWithBase64EncodedString:@"hwLWnp0tXoCzs+W0UdVPUaBSfiW1Q5B9m6xzDPFXvJqpqXvk1nnmMBNziXJWE4M823j8oSRl0uLhCAhxJW6ah7/a25DjGzwa" options:0];
  GHAssertEqualObjects(data, expected, nil);
}

- (void)testHasAllKeys {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
												[NSNumber numberWithBool:YES], @"key2", 
												[NSNumber numberWithBool:NO], @"key3", 
												[NSNull null], @"key4", 
												nil];
	
	BOOL b;
	b = [dict gh_hasAllKeys:nil];
	GHAssertTrue(b, nil);	
	b = [dict gh_hasAllKeys:@"key1", nil];
	GHAssertTrue(b, nil);
	b = [dict gh_hasAllKeys:@"key1", @"key3", nil];
	GHAssertTrue(b, nil);
	b = [dict gh_hasAllKeys:@"key1", @"key4", nil];
	GHAssertFalse(b, nil);
	b = [dict gh_hasAllKeys:@"key1", @"key5", nil];
	GHAssertFalse(b, nil);
	b = [dict gh_hasAllKeys:@"key5", @"key1", nil];
	GHAssertFalse(b, nil);
}

- (void)testSubsetWithKeys {
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
												@"1", @"key1", 
                        @"2", @"key2", 
												nil];
  
  NSDictionary *dictSubset = [dict gh_dictionarySubsetWithKeys:[NSArray arrayWithObject:@"key1"]];
  NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", nil];
  GHAssertEqualObjects(dictSubset, expected, nil);
  
  // Test missing key
  NSDictionary *dictSubset2 = [dict gh_dictionarySubsetWithKeys:[NSArray arrayWithObject:@"key3"]];
  NSDictionary *expected2 = [NSDictionary dictionary];
  GHAssertEqualObjects(dictSubset2, expected2, nil);  
}

- (void)testCompact {
	NSMutableDictionary *dict = [@{@"key1": @"1", @"key2": [NSNull null]} mutableCopy];
  
  NSMutableDictionary *expected = [@{@"key1": @"1"} mutableCopy];

	NSDictionary *after = [dict gh_compactDictionary];
  GHAssertEqualObjects(after, expected, nil);
}

- (void)testJSON {
  NSString *JSONString = [@{@"key1": @(2), @"key2": @(3.1), @"key3": @YES} gh_toJSONString:nil];
  GHAssertEqualStrings(@"{\"key2\":3.1,\"key1\":2,\"key3\":true}", JSONString, nil);
}

@end