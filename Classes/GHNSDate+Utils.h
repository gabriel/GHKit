//
//  GHNSDate+Utils.h
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

@interface NSDate (GHUtils)

/*!
 Add (or subtract) days from date.
 @param days +/- N days
 @result Date with days added or subtracted
 */
- (NSDate *)gh_addDays:(NSInteger)days;

/*!
 Get normalized date (hours/minutes/seconds) set to 0; Begining of day.
 @result Beginning day of current date 
 */
- (NSDate *)gh_beginningOfDay;

/*!
 Yesterday (beginning of day).
 @result Previous day (beginning)
 */
+ (NSDate *)gh_yesterday;

/*!
 Tomorrow (beginning of day).
 @result Next day (beginning)
 */
+ (NSDate *)gh_tomorrow;

/*!
 Check if date is tomorrow.
 @result YES if tomorrow
 */
- (BOOL)gh_isTomorrow;

/*!
 Check if date was or is today.
 @result YES if today
 */
- (BOOL)gh_isToday;

/*!
 Check if date was yesterday.
 @result YES if yesterday
 */
- (BOOL)gh_wasYesterday;

/*!
 Get weekday symbol, with special naming for 'Yesterday', 'Today' and 'Tomorrow'.
 @param formatter Date formatter, if nil will return nil if not yesterday, today or tomorrow
 @result 'Yesterday', 'Today' and 'Tomorrow' or weekday symbol for specified formatter 
 */
- (NSString *)gh_weekday:(NSDateFormatter *)formatter;

/*!
 Time ago in words.
 For more info, especially on localization, see GHNSString+TimeInterval.h.
 
 @param includeSeconds If YES, will include seconds (30 seconds ago), otherwise will say something like 'Less than a minute'
 @result Time ago in words
 */
- (NSString *)gh_timeAgo:(BOOL)includeSeconds;

@end
