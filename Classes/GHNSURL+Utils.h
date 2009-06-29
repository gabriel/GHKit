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

@interface NSURL (GHUtils)

/*!
 Get dictionary from NSURL query parameter.
 @result Dictionary of key, value pairs from parsing query parameter
 */
- (NSMutableDictionary *)gh_queryDictionary;

/*!
 @method gh_dictionaryToQueryString
 @abstract Dictionary to query string. Escapes any encoded characters.
 @param queryDictionary Dictionary of key value params
 @result Query string, key1=value1&key2=value2
 */
+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary;

/*!
 Convert dictionary to URL query string.
 @method gh_dictionaryToQueryString
 @abstract Dictionary to params string. Escapes any encoded characters.
 @param queryDictionary Dictionary
 @param sort If YES, will sort items
 @result Query string, key1=value1&key2=value2
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
 @method gh_queryStringToDictionary
 @param string URL params string, key1=value1&key2=value2
 @result Dictionary
 */
+ (NSMutableDictionary *)gh_queryStringToDictionary:(NSString *)string;

/*!
 Get query string, sorted by key. 
 For example, "b=c&a=d" is returned as "a=d&b=c". 
 @result Sorted query string
 */
- (NSString *)gh_sortedQuery;

/*!
 Derive new URL with a new query. All other fields should be the same.
 @param query
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
 Encode URL string.
 
  "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C
 
 Doesn't encode: ~!@#$&*()=:/,;?+'
 Does encode: %^{}[]"\
 
 Should be the same as javascript's encodeURI().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @method gh_encode
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
 
 @method gh_encodeComponent
 @param s String to encode
 @result Encoded string
 */
+ (NSString *)gh_encodeComponent:(NSString *)s;

/*!
 Encode URL string.
 
 Encodes: @#$%^&{}[]=:/,;?+"\~!*()'
 
 @method gh_escapeAll
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

#ifndef TARGET_OS_IPHONE

/*!
 @method copyLinkToPasteboard
 @abstract Copy URL to pasteboard
 */
- (void)gh_copyLinkToPasteboard;

/*!
 Open file URL. 
 Opens path in Finder or whatever is registered for the file:// scheme.
 @method openFile
 @param path Path to open
 @abstract Open file path
 */
+ (BOOL)gh_openFile:(NSString *)path;

/*!
 Opens directory of file at path (or the path itself if it is a directory),
 in the Finder or whatever is registered for the file:// scheme.
 @method openContainingFolder
 @param path
 @abstract Open folder (in Finder probably) for file path.
 */
+ (void)gh_openContainingFolder:(NSString *)path;

#endif

@end
