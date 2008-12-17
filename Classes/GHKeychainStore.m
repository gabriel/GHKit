//
//  GHKeychainStore.m
//  GHKit
//
//  Created by Gabriel Handford on 12/16/08.
//  Copyright 2008. All rights reserved.
//

#import "GHKeychainStore.h"

//
// For Cocoa target, for GHKeychainStore uses EMKeychainProxy.
// For iPhone target, for GHKeychainStore uses SFHFKeychainUtils.
//

#ifndef TARGET_OS_IPHONE

#import "EMKeychainProxy.h"

@implementation GHEMKeychainStore

+ (id)keychain {
	return [[[GHEMKeychainStore alloc] init] autorelease];
}

// TODO: Set error on failure modes
- (NSString *)secretFromKeychain:(NSString *)accessKey serviceName:(NSString *)serviceName error:(NSError **)error {
  EMGenericKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:serviceName withUsername:accessKey];    
  return [keychainItem password];  
}

- (void)saveToKeychain:(NSString *)serviceName accessKey:(NSString *)accessKey secretAccessKey:(NSString *)secretAccessKey error:(NSError **)error {  
  if (!secretAccessKey) return; // TODO: Handle as error
  EMGenericKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:serviceName withUsername:accessKey];
  if (!keychainItem) {
    [[EMKeychainProxy sharedProxy] addGenericKeychainItemForService:serviceName withUsername:accessKey password:secretAccessKey];
  } else
    [keychainItem setPassword:secretAccessKey];  
}

@end

#else

#import "SFHFKeychainUtils.h"

@implementation GHSFHFKeychainStore

+ (id)keychain {
	return [[[GHSFHFKeychainStore alloc] init] autorelease];
}

- (NSString *)secretFromKeychain:(NSString *)accessKey serviceName:(NSString *)serviceName error:(NSError **)error {
	return [SFHFKeychainUtils passwordForUsername:accessKey serviceName:serviceName error:error];
}

- (void)saveToKeychain:(NSString *)serviceName accessKey:(NSString *)accessKey secretAccessKey:(NSString *)secretAccessKey error:(NSError **)error {
	[SFHFKeychainUtils storeUsername:accessKey password:secretAccessKey serviceName:serviceName updateExisting:YES error:error];
}

@end

#endif