//
//  GHNSURL+Utils.h
//
//  Created by Gabe on 3/19/08.
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

/*!
 Utilities for URLs, for example, encoding, escaping, parsing, splitting out or sorting query params, and more.
 */
@interface NSURL(GHUtils)

/*!
 Get dictionary from NSURL query parameter.
 
 @result Dictionary of key, value pairs from parsing query parameter
 */
- (NSMutableDictionary *)gh_queryDictionary;

/*!
 Dictionary to query string. Escapes any encoded characters.
 
 @param queryDictionary Dictionary of key value params
 @result Query string, key1=value1&amp;key2=value2
 */
+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary;

/*!
 Convert dictionary to URL query string.
 Escapes any encoded characters.
 
 @param queryDictionary Dictionary
 @param sort If YES, will sort items
 @result Query string, key1=value1&amp;key2=value2
 */
+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary sort:(BOOL)sort;

/*!
 Convert dictionary to array of query strings.
 
 @param queryDictionary Dictionary
 @param sort If YES, will sort items
 @param encoded If YES, will be URL component encoded
 @result Query strings, ['key1=value1', 'key2=value2']
 */
+ (NSArray *)gh_dictionaryToQueryArray:(NSDictionary *)queryDictionary sort:(BOOL)sort encoded:(BOOL)encoded;

/*!
 Convert URL query string to dictionary.
 
 @param string URL params string, key1=value1&amp;key2=value2
 @result Dictionary
 */
+ (NSMutableDictionary *)gh_queryStringToDictionary:(NSString *)string;

/*!
 Get query string, sorted by key. 
 For example, "b=c&amp;a=d" is returned as "a=d&amp;b=c". 
 
 @result Sorted query string
 */
- (NSString *)gh_sortedQuery;

/*!
 Derive new URL with a new query. All other fields should be the same.
 
 @param query Query string
 @result URL with new query
 */
- (NSURL *)gh_deriveWithQuery:(NSString *)query;

/*!
 Canonical form of URL.
 
 @result Canonical URL
 */
- (NSURL *)gh_canonical;

/*!
 Canonical form of URL.
 
 @param ignore Do not include the set of query params
 @result Canonical URL
 */
- (NSURL *)gh_canonicalWithIgnore:(NSArray *)ignore;

/*!
 Remove query params.
 
 @param filterQueryParams List of keys to filter 
 @param sort Whether to sort query params
 @result URL without query params.
 */
- (NSURL *)gh_filterQueryParams:(NSArray *)filterQueryParams sort:(BOOL)sort;

/*!
 Encode URL string.
 
    "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C
 
 Doesn't encode: ~!@#$&*()=:/,;?+'
 
 Does encode: %^{}[]"\
 
 Should be the same as javascript's encodeURI().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @param s String to escape
 @result Encode string
 */
+ (NSString *)gh_encode:(NSString *)s;

/*!
 Encode URL string (for escaping URL key/value params).
 
 "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C
 
 Doesn't encode: ~!*()'
 
 Does encode: @#$%^&{}[]=:/,;?+"\
 
 Should be the same as javascript's encodeURIComponent().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @param s String to encode
 @result Encoded string
 */
+ (NSString *)gh_encodeComponent:(NSString *)s;

/*!
 Encode URL string.
 
 Encodes: @#$%^&{}[]=:/,;?+"\~!*()'
 
 @param s String to encode
 @result Encoded string
 */ 
+ (NSString *)gh_escapeAll:(NSString *)s;

/*!
 Decode URL string.
 
 @param s String to decode
 @result Decoded URL string
 */
+ (NSString *)gh_decode:(NSString *)s;

#if TARGET_OS_OSX

/*!
 Copy URL to pasteboard. For Mac OS X only.
 */
- (void)gh_copyLinkToPasteboard;

/*!
 Open file URL. 
 Opens path in Finder or whatever is registered for the file:// scheme.
 For Mac OS X only.
 
 @param path Path to open
 @result YES if opened
 */
+ (BOOL)gh_openFile:(NSString *)path;

/*!
 Opens directory of file at path (or the path itself if it is a directory),
 in the Finder or whatever is registered for the file:// scheme.
 For Mac OS X only.
 
 @param path Path
 */
+ (void)gh_openContainingFolder:(NSString *)path;

#endif

@end
