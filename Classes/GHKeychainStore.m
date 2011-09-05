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

#import "GHNSError+Utils.h"

NSString *const GHEMKeychainStoreErrorDomain = @"GHEMKeychainStoreErrorDomain";

// Uses SFHFKeychainUtils (iPhone)
@interface GHSFHFKeychainStore : NSObject <GHKeychainStore> {}
@end

// Uses EMKeychainProxy (Cocoa)
@interface GHEMKeychainStore : NSObject <GHKeychainStore> {}
@end

@implementation GHKeychainStore

- (id)init {
	if ((self = [super init])) {
#if TARGET_OS_IPHONE
		_keychainStore = [[GHSFHFKeychainStore alloc] init];
#else
		_keychainStore = [[GHEMKeychainStore alloc] init];
#endif
	}
	return self;
}

- (void)dealloc {
	[_keychainStore release];
	[super dealloc];
}

- (NSString *)secretFromKeychainForServiceName:(NSString *)serviceName key:(NSString *)key error:(NSError **)error {
	return [_keychainStore secretFromKeychainForServiceName:serviceName key:key error:error];
}

- (BOOL)saveToKeychainWithServiceName:(NSString *)serviceName key:(NSString *)key secret:(NSString *)secret error:(NSError **)error {
	return [_keychainStore saveToKeychainWithServiceName:serviceName key:key secret:secret error:error];
}


@end


#if !TARGET_OS_IPHONE

#import "EMKeychainProxy.h"

@implementation GHEMKeychainStore

- (NSString *)secretFromKeychainForServiceName:(NSString *)serviceName key:(NSString *)key error:(NSError **)error {
	// TODO: Set error on failure modes from EMGenericKeychainItem (which doesn't have any)
  EMGenericKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:serviceName withUsername:key];    
  return [keychainItem password];  
}

- (BOOL)saveToKeychainWithServiceName:(NSString *)serviceName key:(NSString *)key secret:(NSString *)secret error:(NSError **)error {  
  if (!secret) {
		if (error) *error = [NSError gh_errorWithDomain:GHEMKeychainStoreErrorDomain code:GHEMKeychainStoreErrorCodeInvalidSecret localizedDescription:@"Invalid secret"];
		return NO;
	}
  EMGenericKeychainItem *keychainItem = [[EMKeychainProxy sharedProxy] genericKeychainItemForService:serviceName withUsername:key];
  if (!keychainItem) {
    [[EMKeychainProxy sharedProxy] addGenericKeychainItemForService:serviceName withUsername:key password:secret];
  } else
    [keychainItem setPassword:secret];
  
	return YES;
}

@end

#endif


#if TARGET_OS_IPHONE

@protocol GHKit_SFHFKeychainUtils
+ (NSString *)getPasswordForUsername:(NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error;
+ (void) storeUsername:(NSString *)username andPassword:(NSString *)password forServiceName:(NSString *)serviceName updateExisting:(BOOL)updateExisting error:(NSError **) error;
@end

@implementation GHSFHFKeychainStore

- (Class)keychainUtilsClass {
  Class keychainUtilsClass = NSClassFromString(@"SFHFKeychainUtils");
  if (keychainUtilsClass == NULL) 
    [NSException raise:NSDestinationInvalidException format:@"Must import SFHFKeychainUtils to use the keychain store"];
  return keychainUtilsClass;
}

- (NSString *)secretFromKeychainForServiceName:(NSString *)serviceName key:(NSString *)key error:(NSError **)error {
	
	if (!error) {
		NSError *errorTmp = nil;
		error = &errorTmp;
	}
	
	return [[self keychainUtilsClass] getPasswordForUsername:key andServiceName:serviceName error:error];
}

- (BOOL)saveToKeychainWithServiceName:(NSString *)serviceName key:(NSString *)key secret:(NSString *)secret error:(NSError **)error {
	if (!secret) {
		if (error) *error = [NSError gh_errorWithDomain:GHEMKeychainStoreErrorDomain code:GHEMKeychainStoreErrorCodeInvalidSecret localizedDescription:@"Invalid secret"];
		return NO;
	}
	
	if (!error) {
		NSError *errorTmp = nil;
		error = &errorTmp;
	}
	
	[[self keychainUtilsClass] storeUsername:key andPassword:secret forServiceName:serviceName updateExisting:YES error:error];
	if (error && *error) return NO;
	return YES;
}

@end

#endif
