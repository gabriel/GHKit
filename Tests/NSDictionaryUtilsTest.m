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

@end