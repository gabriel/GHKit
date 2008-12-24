//
//  GHKeychainStore.m
//  GHKit
//
//  Copyright 2008 Gabriel Handford
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
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