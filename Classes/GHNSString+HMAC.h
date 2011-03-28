//
//  GHNSString+HMAC.h
//
//  Created by Gabe on 7/02/08.
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

/*!
 Utilities for generating a SHA-1 HMAC on a string based on a
 secret and Base64 encoder.
 */
@interface NSString(GHHMAC)

/*!
 HMAC SHA1 digest.
 
 For the Base64 encoder you can user GTMBase64, or that implements:
 @code
 - (NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
 @endcode
 
 @code
 // #import <GHKit/GTMBase64.h>
 ["stringtosign" gh_HMACSHA1:@"mysecret" base64Encoder:[GTMBase64 class]];
 @endcode
 
 @param secret Secret key to sign with
 @param base64Encoder Base64 encoder, that implements: (NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
 @result Base64 encoded HMAC SHA1 digest
 */
- (NSString *)gh_HMACSHA1:(NSString *)secret base64Encoder:(id)base64Encoder;

@end
