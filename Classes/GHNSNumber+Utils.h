//
//  GHNSNumber+Utils.h
//
//  Created by Gabe on 6/24/08.
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


@interface NSNumber (GHUtils)

/*!
 @method gh_humanSize
 @abstract File size label
 @result '904 b', '32 KB', '1.1 MB', 
 */
- (NSString *)gh_humanSize;

/*!
 @method gh_humanSize
 @abstract File size label
 @param delimiter In between numeric and unit
 @result '904 b', '32 KB', '1.1 MB', 
 */
- (NSString *)gh_humanSizeWithDelimiter:(NSString *)delimiter;

/*!
 Ordinalize.
 @result Ordinal string for integer.
 0 => nil
 1 => "1st"
 2 => "2nd"
 3 => "3rd"
 4-9 -> "4th", "5th", ...
 Ending in 11, 12 or 13 => "111th", "212th", ...
 */
- (NSString *)gh_ordinalize;

/*!
 Ordinalize (masculine).
 @param masuline If YES will format for masculine
 @result Ordinal string for integer
 */
- (NSString *)gh_ordinalizeMasculine:(BOOL)masculine;

/*!
 Ordinalize.
 @param value
 @result Ordinal string for integer.
 @see gh_ordinalize
 */
+ (NSString *)gh_ordinalize:(NSInteger)value;

/*!
 Ordinalize.
 @param value
 @param masculine
 @result Ordinal string for integer.
 @see gh_ordinalizeMasculine:
 */
+ (NSString *)gh_ordinalize:(NSInteger)value masculine:(BOOL)masculine;

+ (NSNumber *)gh_bool:(BOOL)b;
+ (NSNumber *)gh_no;
+ (NSNumber *)gh_yes;

+ (NSInteger)gh_randomInteger;

@end
