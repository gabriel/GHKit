//
//  GHEMKeychainStoreTest.m
//  GHKit
//
//  Created by Gabriel Handford on 9/12/09.
//  Copyright 2009. All rights reserved.
//

#import "GHKeychainStore.h"

@interface GHKeychainStoreTest : GHTestCase { }
@end


@implementation GHKeychainStoreTest

- (void)testSave {
	
	GHKeychainStore *keychainStore = [[GHKeychainStore alloc] init];
	BOOL saved = [keychainStore saveToKeychainWithServiceName:@"GHEMKeychainStoreTest" key:@"TestKey" secret:@"TestSecret" error:nil];
	GHAssertTrue(saved, nil); // Jesus saves, I spend
	
	NSString *secret = [keychainStore secretFromKeychainForServiceName:@"GHEMKeychainStoreTest" key:@"TestKey" error:nil];
	GHAssertEqualStrings(secret, @"TestSecret", nil);
	
	[keychainStore release];
	
}

- (void)testErrorInvalidSecret {
	
	GHKeychainStore *keychainStore = [[GHKeychainStore alloc] init];
	NSError *error = nil;
	BOOL saved = [keychainStore saveToKeychainWithServiceName:@"GHEMKeychainStoreTest" key:@"TestKey" secret:nil error:&error];
	GHAssertFalse(saved, nil);
	GHAssertNotNil(error, nil);
	GHAssertTrue([error code] == 1, nil);
	
	[keychainStore release];
}

- (void)testSaveEmpty {
	
	GHKeychainStore *keychainStore = [[GHKeychainStore alloc] init];
	NSError *error = nil;
	BOOL saved = [keychainStore saveToKeychainWithServiceName:@"GHEMKeychainStoreTest" key:@"TestKey" secret:@"" error:&error];
	GHAssertTrue(saved, nil);
	
	[keychainStore release];
}


@end
