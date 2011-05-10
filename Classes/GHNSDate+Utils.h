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

// Common date format constant: 'Dec 12, 2008 4:34 PM'
extern NSString *const kDateFormatShortMonthFullYearTime;

/*!
 Utilities for dates, for time ago in words and date component arithmentic (adding days), tomorrow, yesterday, and more.
 */
@interface NSDate(GHUtils)

/*!
 Return new date by adding (or subtracting) days from date.
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
 Format date.
 @param format
 @param useWeekday If YES, will prepend weekday (or 'Today', 'Tomorrow', 'Yesterday')
 */
- (NSString *)gh_format:(NSString *)format useWeekday:(BOOL)useWeekday;

/*!
 Create date from date and add days and/or normalize.
 @param date The date to start at
 @param addDay If not 0, will add these number of days to the date.
 @param normalize If YES will set hours, minutes, seconds to 0
 */
+ (NSDate *)gh_dateFromDate:(NSDate *)date addDay:(NSInteger)addDay normalize:(BOOL)normalize;

/*!
 Create date with day, month, year, and add days, months or years.
 
 To use the current day, month or year, specify 0 for that value.
 
 For example, the use Jan, 1 30 years ago:
 
 @code
 [NSDate gh_dateWithDay:1 month:1 year:0 addDay:0 addMonth:0 addYear:-30 
  timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
 @endcode
 
 @param day Day to set (if 0, uses current day)
 @param month Month to set (if 0, uses current month)
 @param year Year to set (if 0, uses current year)
 @param addDay Days to add
 @param addMonth Month to add
 @param addYear Year to add
 @param timeZone Time zone to use
 @result Date
 */
+ (NSDate *)gh_dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year 
                    addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear 
                  timeZone:(NSTimeZone *)timeZone;

/*!
 Create date with day, month, year.
 
 To use the current day, month or year, specify 0 for that value.
 
 For example, the use Jan, 1 (current year):
 
 @code
 [NSDate gh_dateWithDay:1 month:1 year:0 timeZone:nil];
 @endcode
 
 @param day Day to set (if 0, uses current day)
 @param month Month to set (if 0, uses current month)
 @param year Year to set (if 0, uses current year)
 @result Date
 */
+ (NSDate *)gh_dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                  timeZone:(NSTimeZone *)timeZone;

/*!
 Date components for date.
 @param flags Flags, e.g. NSMonthCalendarUnit, or NSMonthCalendarUnit | NSYearCalendarUnit
 @param timeZone
 @result Date components
 */
- (NSDateComponents *)gh_dateComponentsFromFlags:(NSUInteger)flags timeZone:(NSTimeZone *)timeZone;

/*!
 Month symbols.
 @param format MM for numeric, or MMMM for full string.
 */
+ (NSArray *)gh_monthSymbolsForFormat:(NSString *)format;

/*!
 Day of date.
 @result Day
 */
- (NSInteger)gh_day;

/*!
 Day of date.
 @param timeZone
 @result Day
 */
- (NSInteger)gh_dayForTimeZone:(NSTimeZone *)timeZone;

/*!
 Month of date.
 @result Year
 */
- (NSInteger)gh_month;

/*!
 Month of date.
 @param timeZone
 @result Month
 */
- (NSInteger)gh_monthForTimeZone:(NSTimeZone *)timeZone;

/*!
 Year of date.
 @result Year
 */
- (NSInteger)gh_year;

/*!
 Year of date.
 @param timeZone
 @result Year
 */
- (NSInteger)gh_yearForTimeZone:(NSTimeZone *)timeZone;


/*!
 Time ago in words.
 For more info, especially on localization, see GHNSString+TimeInterval.h.
 
 These are the localized defaults, that you can override:
 
 @verbatim
 LessThanAMinute = "less than a minute";
 LessThanXSeconds = "less than %d seconds";
 HalfMinute = "half a minute";
 1Minute = "1 minute";
 XMinutes = "%.0f minutes";
 About1Hour = "about 1 hour";
 AboutXHours = "about %.0f hours";
 1Day = "1 day";
 XDays = "%.0f days";
 About1Month = "about 1 month";
 XMonths = "%.0f months";
 About1Year = "about 1 year";
 OverXYears = "over %.0f years";
 @endverbatim
 
 @param includeSeconds If YES, will include seconds (30 seconds ago), otherwise will say something like 'Less than a minute'
 @result Time ago in words
 */
- (NSString *)gh_timeAgo:(BOOL)includeSeconds;

/*!
 Milliseconds since 1970.
 @result Milliseconds since 1970 GMT.
 */
- (long long)gh_millisSince1970;

/*!
 Milliseconds since 1970 (NSNumber).
 @result Milliseconds since 1970 GMT
 */
- (NSNumber *)gh_millisNumberSince1970;

/*!
 Seconds since 1970.
 @result Seconds since 1970 GMT (rounded)
 */
- (long long)gh_secondsSince1970;

/*!
 Seconds since 1970 (NSNumber).
 @result Seconds since 1970 GMT (rounded)
 */
- (NSNumber *)gh_secondsNumberSince1970;

@end
