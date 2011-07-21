//
//  GHKit.h
//
//  Created by Gabe on 6/30/08.
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

#import "GHKitDefines.h"

#import "GHNSDate+Parsing.h"
#import "GHNSDate+Utils.h"

#import "GHNSFileManager+Utils.h"

#import "GHNSString+HMAC.h"
#import "GHNSString+TimeInterval.h"
#import "GHNSString+Utils.h"
#import "GHNSString+URL.h"

#import "GHNSNumber+Utils.h"

#import "GHNSURL+Utils.h"

#import "GHNSArray+Utils.h"
#import "GHNSMutableArray+Utils.h"
#import "GHNSDictionary+Utils.h"
#import "GHNSMutableDictionary+Utils.h"
#import "GHNSDictionary+NSNull.h"
#import "GHReversableDictionary.h"

#import "GHNSInvocationProxy.h"
#import "GHNSInvocation+Utils.h"
#import "GHNSObject+Invocation.h"
#import "GHNSError+Utils.h"
#import "GHNSBundle+Utils.h"
#import "GHNSStringEnumerator.h"

#import "GHNSNotificationCenter+Utils.h"
#import "GHNSObject+Swizzle.h"

#import "GHKeychainStore.h"
#import "GHCGUtils.h"

#import "GHValidators.h"
#import "GHNSUserDefaults+Utils.h"

// iPhone
#if TARGET_OS_IPHONE
#import "GHNSString+UIKitUtils.h"
#import "GHUIColor+Utils.h"
#else
#import "GHViewAnimation.h"
#import "GHNSXMLNode+Utils.h"
#import "GHNSXMLElement+Utils.h"
#import "GHNSAttributedString+Utils.h"
#import "GHNSString+SymlinksAndAliases.h"
#endif

#import "GHNSObject+Utils.h"


/*! 
 @mainpage GHKit
 
 GHKit defines various categories and general purpose utilities.
 For example, parsing date strings, generating time ago in words,
 generating SHA1-HMAC, MD5, or special invocation proxies.
 
 Source: http://github.com/gabriel/gh-kit
 
 View docs online: http://gabriel.github.com/gh-kit/
 
 To use the framework (for iOS):
 
 @code
 #import <GHKitIOS/GHKitIOS.h>
 @endcode
 
 To use the framework (for Mac OS X):
 
 @code
 #import <GHKit/GHKit.h>
 @endcode
 
 @section Dates Dates
 
 <tt>GHNSDate+Parsing.h</tt>: Date parsers, formatting and formatters for ISO8601, RFC822, HTTP (RFC1123, RFC850, asctime) and since epoch.
 
 @code
 NSDate *date = [NSDate gh_parseISO8601:@"2010-10-07T04:25Z"]
 
 NSString *dateString = [date gh_formatHTTP]; // Formatted like: Sun, 06 Nov 1994 08:49:37 GMT"
 @endcode
 
 <tt>GHNSDate+Utils.h</tt>: For time ago in words and date component arithmentic (adding days), tomorrow, yesterday, and more.
 
 @code
 NSDate *date = [NSDate date];
 [date gh_isToday]; // YES
 [[date gh_yesterday] gh_isToday]; // NO
 
 date = [date gh_addDays:-1];
 [date gh_wasYesterday]; // YES

 [date gh_timeAgo:NO]; // @"1 day"
 @endcode
 
 @section Strings Strings
 
 <tt>GHNSString+Utils.h</tt>: Stripping, reversing, counting, UUID, MD5 and more.
 
 @code
 [NSString gh_isBlank:@"  "]; // YES
 [NSString gh_isBlank:nil]; // YES
 
 [@"abc" gh_reverse]; // @"cba"
 
 [@"  some text " gh_strip]; // @"some text"
 @endcode

 @section URLs URLs
 
 <tt>GHNSURL+Utils.h</tt>: Encoding, escaping, parsing, splitting out or sorting query params, and more.
 
 @code
 NSDictionary *dict = [@"c=d&a=b" gh_queryStringToDictionary]; // Dictionary with a => b, c => d
 [NSDictionary gh_dictionaryToQueryString:dict sort:YES]; // @"a=b&c=d"
 @endcode

 @section Invocation Invocation
 
 <tt>GHNSObject+Invocation.h</tt>: 
 
 @code
 [[obj gh_proxyOnMainThread] myMethodWithInteger:4 string:@"string"]; // Call myMethod on main thread
 
 [[array gh_proxyAfterDelay:2.0] insertObject:@"foo" atIndex:0]; // Inserts object after 2 second delay
 
 SEL selector = @selector(bar:baz:);
 [foo gh_argumentProxy:selector] arg:10 arg:YES];
 
 Will call <tt>[foo bar:10 baz:YES];</tt>  (and not <tt>arg:arg:</tt> selector which doesn't exist).
 @endcode
 
 @section File File
 
 <tt>GHNSFileManager+Utils.h</tt>: File size, exists, generating temporary or unique file paths.
 
 @section HMAC HMAC
 
 <tt>GHNSString+HMAC.h</tt>: SHA-1 HMAC
 
 @code
 #import "GTMBase64.h"
 ["stringtosign" gh_HMACSHA1:@"secret" base64Encoder:[GTMBase64 class]];
 @endcode
 
 @section Keychain Keychain
 
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
 
 @section More And more...
 */

