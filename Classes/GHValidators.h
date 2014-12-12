//
//  GHNSString+Validation.h
//
//  Created by Gabe on 7/20/08.
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
 Validators for input, such as email addresses.
 */
@interface GHValidators : NSObject { }

/*!
 Check if string is a valid email address.

 @param str String to validate
 @result YES if string is a valid email address
 */
+ (BOOL)isEmailAddress:(NSString *)str;

/*!
 Check if credit card number passes Luhn validation.
 
 @param numberString Credit card number as string
 @result YES if passes luhn validation
 */
+ (BOOL)isCreditCardNumber:(NSString *)numberString;

/*!
 Check if string is a valid credit card expiration.
 Accept 1/12, 01/12, or 01/2012, or 01/10/2012.
 
 @param expiration Expiration string.
 @param date Current date, fails if expiration < this date
 @result YES if passes validation
 */
+ (BOOL)isCreditCardExpiration:(NSString *)expiration date:(NSDate *)date;

@end
