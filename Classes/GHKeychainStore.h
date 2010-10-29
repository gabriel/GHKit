//
//  GHKeychainStore.h
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

#import <Foundation/Foundation.h>

extern NSString *const GHEMKeychainStoreErrorDomain;

typedef enum {
	GHEMKeychainStoreErrorCodeInvalidSecret = 1
} GHEMKeychainStoreErrorCode;

/*!
 Protocol for keychain storage. 
 */
@protocol GHKeychainStore <NSObject>

/*!
 Get secret from keychain.
 @param key
 @param serviceName
 @param error
 @result Secret
 */
- (NSString *)secretFromKeychainForServiceName:(NSString *)serviceName key:(NSString *)key error:(NSError **)error;

/*!
 Save secret to keychain.
 @param serviceName
 @param key
 @param secret
 @param error
 @result NO if there was an error, YES otherwise
 */
- (BOOL)saveToKeychainWithServiceName:(NSString *)serviceName key:(NSString *)key secret:(NSString *)secret error:(NSError **)error;

@end

/*!
 Keychain store adapter which works on both iOS and Mac OS X.
 
 Forwards to:
	- GHEMKeychainStore for Mac OS X.
	- GHSFHFKeychainStore for iPhone.

 
 Secret from keychain:
 
 @code
 GHKeychainStore *keyChainStore = [[GHKeychainStore alloc] init];
 NSError *error = nil;
 NSString *secret = [keyChainStore secretFromKeychainForServiceName:@"MyApp" key:"password" error:&error];
 if (!secret) NSLog(@"Error: %@", [error localizedDescription];
 @endcode
 
 Save to keychain:
 
 @code
 GHKeychainStore *keyChainStore = [[GHKeychainStore alloc] init];
 NSError *error = nil;
 BOOL saved = [keyChainStore saveToKeychainWithServiceName:@"MyApp" key:"password" secret:"12345" error:&error];
 if (!saved) NSLog(@"Error: %@", [error localizedDescription];
 @endcode
 
 */
@interface GHKeychainStore : NSObject <GHKeychainStore> {
	id<GHKeychainStore> _keychainStore;
}

@end

