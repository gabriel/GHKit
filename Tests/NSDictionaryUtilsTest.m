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
	NSMutableDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"1", @"key1",
                               [NSNull null], @"key2", 
                               nil];
  
  NSMutableDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"1", @"key1",
                                   nil];

	NSDictionary *after = [dict gh_compactDictionary];
  GHAssertEqualObjects(after, expected, nil);
}

@end