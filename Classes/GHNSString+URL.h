//
//  GHNSString+URL.h
//  GHKit
//
//  Created by Gabriel Handford on 2/18/09.
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

#import "GHNSURL+Utils.h"

/*!
 Utilities for URL encoding/decoding.
 */
@interface NSString(GHURL)

/*!
 Decode URL encoded string.
 @see NSURL#gh_decode:
 */
- (NSString *)gh_URLDecode;

/*!
 Encode URL string.
 
    "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C
 
 Doesn't encode: ~!@#$&*()=:/,;?+'
 
 Does encode: %^{}[]"\
 
 Should be the same as javascript's encodeURI().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @see NSURL#gh_encode:
 */
- (NSString *)gh_URLEncode;

/*!
 Encode URL string (for escaping URL key/value params).
 
    "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C
 
 Doesn't encode: ~!*()'
 
 Does encode: @#$%^&{}[]=:/,;?+"\
 
 Should be the same as javascript's encodeURIComponent().
 See http://xkr.us/articles/javascript/encode-compare/
  
 @see NSURL#gh_encodeComponent
 */
- (NSString *)gh_URLEncodeComponent;

/*!
 Encode URL string (all characters).
 
 Encodes: @#$%^&{}[]=:/,;?+"\~!*()' 
 
 @see NSURL#gh_escapeAll
 */
- (NSString *)gh_URLEscapeAll;

@end
