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

@implementation NSDate (GHUtils)

NSUInteger const kUnitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;

+ (NSDate *)_gh_normalizedDate:(NSDate *)date adjustDay:(NSInteger)adjustDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:kUnitFlags fromDate:date];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	if (adjustDay != 0) [comps setDay:[comps day] + adjustDay];
	return [calendar dateFromComponents:comps];	
}

- (NSDate *)gh_addDays:(NSInteger)days {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:kUnitFlags fromDate:self];
	if (days != 0) [comps setDay:[comps day] + days];
	return [calendar dateFromComponents:comps];		
}

- (NSDate *)gh_beginningOfDay {
	return [NSDate _gh_normalizedDate:self adjustDay:0];
}

+ (NSDate *)gh_yesterday {	
	return [NSDate _gh_normalizedDate:[NSDate date] adjustDay:-1];
}

+ (NSDate *)gh_tomorrow {	
	return [NSDate _gh_normalizedDate:[NSDate date] adjustDay:1];
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
	if ([self gh_isTomorrow]) return @"Tomorrow";
	else if ([self gh_isToday]) return @"Today";
	else if ([self gh_wasYesterday]) return @"Yesterday";
	
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
	[dateFormatter release];
	return formatted;
}

- (NSString *)gh_timeAgo:(BOOL)includeSeconds {	
	return [NSString gh_stringForTimeInterval:[self timeIntervalSinceNow] includeSeconds:includeSeconds];
}

- (long long)gh_millisSince1970 {
	NSTimeInterval secondsSince1970 = [self timeIntervalSince1970];
	return (long long)round(secondsSince1970 * 1000);
}

- (NSNumber *)gh_millisNumberSince1970 {
	long long millis = [self gh_millisSince1970];
	return [NSNumber numberWithLongLong:millis];
}

- (long long)gh_secondsSince1970 {
	NSTimeInterval secondsSince1970 = [self timeIntervalSince1970];
	return (long long)round(secondsSince1970);
}

- (NSNumber *)gh_secondsNumberSince1970 {
	long long seconds = [self gh_secondsSince1970];
	return [NSNumber numberWithLongLong:seconds];
}

@end
