//
//  GHKeychainStore.h
//  GHKit
//
//  Created by Gabriel Handford on 12/16/08.
//  Copyright 2008. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GHKeychainStore
+ (id)keychain;
- (NSString *)secretFromKeychain:(NSString *)accessKey serviceName:(NSString *)serviceName error:(NSError **)error;
- (void)saveToKeychain:(NSString *)serviceName accessKey:(NSString *)accessKey secretAccessKey:(NSString *)secretAccessKey error:(NSError **)error;

@end

// Uses SFHFKeychainUtils (iPhone)
@interface GHSFHFKeychainStore : NSObject <GHKeychainStore> {}
@end

// Uses EMKeychainProxy (Cocoa)
@interface GHEMKeychainStore : NSObject <GHKeychainStore> { }
@end

