//
//  GHNSDate+Utils.m
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

#import "GHNSDate+Utils.h"
#import "GHNSString+TimeInterval.h"

// Common date formats
NSString *const kDateFormatShortMonthFullYearTime = @"LLL d, yyyy hh:mm a";

@implementation NSDate(GHUtils)

NSUInteger const kUnitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;

+ (NSDate *)_gh_dateFromDate:(NSDate *)date day:(NSInteger)day month:(NSInteger)month year:(NSInteger)year 
                     addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear 
                  normalize:(BOOL)normalize timeZone:(NSTimeZone *)timeZone {
	NSCalendar *calendar = [NSCalendar currentCalendar];
  if (timeZone) {
    [calendar setTimeZone:timeZone];
  }
  NSDateComponents *comps = [calendar components:kUnitFlags fromDate:date];
  if (normalize) {
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
  }
	if (day != 0) [comps setDay:day];
  if (month != 0) [comps setMonth:month];
  if (year != 0) [comps setYear:year];
  
  if (addDay != 0) [comps setDay:([comps day] + addDay)];
  if (addMonth != 0) [comps setMonth:([comps month] + addMonth)];
  if (addYear != 0) [comps setYear:([comps year] + addYear)];  
  
	return [calendar dateFromComponents:comps];	
}

+ (NSDate *)gh_dateFromDate:(NSDate *)date addDay:(NSInteger)addDay normalize:(BOOL)normalize {
  return [self _gh_dateFromDate:date day:0 month:0 year:0 addDay:addDay addMonth:0 addYear:0 
                     normalize:normalize timeZone:nil];
}

+ (NSDate *)gh_dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                  timeZone:(NSTimeZone *)timeZone {
  return [self gh_dateWithDay:day month:month year:year addDay:0 addMonth:0 addYear:0 timeZone:timeZone];
}

+ (NSDate *)gh_dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year 
                    addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear 
                  timeZone:(NSTimeZone *)timeZone {
  return [self _gh_dateFromDate:[NSDate date] day:day month:month year:year addDay:addDay addMonth:addMonth addYear:addYear 
                      normalize:YES timeZone:timeZone];

}

- (NSDateComponents *)gh_dateComponentsFromFlags:(NSUInteger)flags timeZone:(NSTimeZone *)timeZone {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  if (timeZone) {
    [calendar setTimeZone:timeZone];
  }
  return [calendar components:flags fromDate:self];  
}

- (NSInteger)gh_day {
  return [self gh_dayForTimeZone:nil];
}

- (NSInteger)gh_dayForTimeZone:(NSTimeZone *)timeZone {
  return [[self gh_dateComponentsFromFlags:NSCalendarUnitDay timeZone:timeZone] day];
}

- (NSInteger)gh_month {
  return [self gh_monthForTimeZone:nil];
}

- (NSInteger)gh_monthForTimeZone:(NSTimeZone *)timeZone {
  return [[self gh_dateComponentsFromFlags:NSCalendarUnitMonth timeZone:timeZone] month];
}

- (NSInteger)gh_year {
  return [self gh_yearForTimeZone:nil];
}

- (NSInteger)gh_yearForTimeZone:(NSTimeZone *)timeZone {
  return [[self gh_dateComponentsFromFlags:NSCalendarUnitYear timeZone:timeZone] year];
}

+ (NSArray *)gh_monthSymbols {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSArray *monthSymbols = [dateFormatter standaloneMonthSymbols];
  return monthSymbols;
}

- (NSDate *)gh_addDays:(NSInteger)days {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:kUnitFlags fromDate:self];
	if (days != 0) [comps setDay:[comps day] + days];
	return [calendar dateFromComponents:comps];		
}

- (NSDate *)gh_beginningOfDay {
	return [NSDate gh_dateFromDate:self addDay:0 normalize:YES];
}

+ (NSDate *)gh_yesterday {	
	return [NSDate gh_dateFromDate:[NSDate date] addDay:-1 normalize:YES];
}

+ (NSDate *)gh_tomorrow {	
	return [NSDate gh_dateFromDate:[NSDate date] addDay:1 normalize:YES];
}

- (BOOL)gh_isTomorrow {
	return ([[self gh_beginningOfDay] compare:[NSDate gh_tomorrow]] == NSOrderedSame);
}

- (BOOL)gh_isToday {
	return ([[self gh_beginningOfDay] compare:[[NSDate date] gh_beginningOfDay]] == NSOrderedSame);
}

- (BOOL)gh_wasYesterday {
	return ([[self gh_beginningOfDay] compare:[NSDate gh_yesterday]] == NSOrderedSame);
}

- (NSString *)gh_weekday:(NSDateFormatter *)formatter {
	if ([self gh_isTomorrow]) return NSLocalizedString(@"Tomorrow", nil);
	else if ([self gh_isToday]) return NSLocalizedString(@"Today", nil);
	else if ([self gh_wasYesterday]) return NSLocalizedString(@"Yesterday", nil);
	
	if (!formatter) return nil;
	
	NSInteger weekday = [[[NSCalendar currentCalendar] components:kUnitFlags fromDate:self] weekday] - 1;
	return [[formatter weekdaySymbols] objectAtIndex:weekday];
}

- (NSString *)gh_format:(NSString *)format useWeekday:(BOOL)useWeekday {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format]; 
	NSString *formatted = [dateFormatter stringFromDate:self];
	if (useWeekday) {
		NSString *specialWeekday = [self gh_weekday:dateFormatter]; 
	 formatted = [NSString stringWithFormat:@"%@, %@", specialWeekday, formatted];
	}
	return formatted;
}

- (NSString *)gh_timeAgo:(BOOL)includeSeconds {	
	return [NSString gh_stringForTimeInterval:[self timeIntervalSinceNow] includeSeconds:includeSeconds];
}

- (NSString *)gh_timeAgoAbbreviated {
  return [NSString gh_abbreviatedStringForTimeInterval:[self timeIntervalSinceNow]];
}

@end
