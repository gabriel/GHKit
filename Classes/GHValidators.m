//
//  GHValidators.m
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

#import "GHValidators.h"
#import "GHNSDate+Utils.h"

//! @cond DEV

@protocol GHValidators_GTMRegex
+ (id)regexWithPattern:(NSString *)pattern options:(NSUInteger)options;
- (BOOL)matchesString:(NSString *)str;
@end  

//! @endcond

@implementation GHValidators

+ (id)regexWithPattern:(NSString *)pattern options:(NSUInteger)options {
  Class regexClass = NSClassFromString(@"GTMRegex");
  if (regexClass == NULL) 
    [NSException raise:NSDestinationInvalidException format:@"Must include GTMRegex in order to use this validator."];
  return [regexClass regexWithPattern:pattern options:options];  
}  

+ (BOOL)isEmailAddress:(NSString *)str {
  // Simple regex from http://www.regular-expressions.info/email.html
  NSString *emailRegexPattern = @"^[A-Z0-9._%+-\\'\"]+@[A-Z0-9.-]+\\.[A-Z]+$";  
  NSUInteger options = 0x01; // kGTMRegexOptionIgnoreCase
  id regex = [self regexWithPattern:emailRegexPattern options:options];
  return [regex matchesString:str];
}

+ (BOOL)isCreditCardNumber:(NSString *)numberString {
  NSInteger digitsLength = [numberString length];
  if (digitsLength == 0) return NO;
  NSInteger digitsArray[digitsLength];
  for (NSInteger i = 0; i < digitsLength; i++) {
    NSString *digitString = [numberString substringWithRange:NSMakeRange(i, 1)];
    // Check for 0 manually since integerValue returns 0 on failure
    if ([digitString isEqual:@"0"]) {
      digitsArray[i] = 0;
    } else {
      NSInteger digit = [digitString integerValue];
      if (digit == 0) return NO;
      digitsArray[i] = digit;
    }
  }
  
  for (NSInteger i = digitsLength - 2; i > -1; i-=2) {
    digitsArray[i] *= 2;
    if (digitsArray[i] > 9) {
      digitsArray[i] -= 9;
    }
  }
  
  NSInteger total = 0;
  for (NSInteger i = 0; i < digitsLength; i++) {
    total += digitsArray[i];
  }
  
  return (total % 10 == 0);
}

+ (BOOL)isCreditCardExpiration:(NSString *)expiration date:(NSDate *)date {
  if (!expiration) return NO;
  NSArray *split = [expiration componentsSeparatedByString:@"/"];
  if ([split count] != 2) return NO;
  NSInteger month = [[split objectAtIndex:0] integerValue];
  NSInteger year = [[split objectAtIndex:1] integerValue];
  if (month <= 0 || year <= 0) return NO;
  if (month > 12) return NO;
  
  if (year >= 0 && year < 100) year += 2000; // TODO(gabe): Y3K
  
  if (date) {
    // Check >= date.
    // Comparing date components like this isn't completely precise across time zones
    // so we ignore the first day of the month.
    NSInteger currentYear = [date gh_year];
    if (year < currentYear) return NO;
    if (year == currentYear && month < [date gh_month] && [date gh_day] != 1) {
      return NO;
    }
  }
  return YES;
}

@end
