//
//  NSDate+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 2/18/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSDate+Utils.h"

@interface NSDateUtilsTest : GHTestCase { }
@end

@implementation NSDateUtilsTest

- (void)testYesterday {
	NSDate *date = [[NSDate date] addTimeInterval:-(60 * 60 * 24)]; // This could fail daylight savings
	GHAssertTrue([date gh_wasYesterday], nil);
}

- (void)testTomorrow {
	NSDate *date = [[NSDate date] addTimeInterval:(60 * 60 * 24)]; // This could fail daylight savings
	GHAssertTrue([date gh_isTomorrow], nil);
}

- (void)testWeekday {
	GHTestLog(@"[NSDate gh_tomorrow]: %@", [NSDate gh_tomorrow]);
	GHAssertEqualObjects([[NSDate gh_yesterday] gh_weekday:nil], @"Yesterday", nil);
	GHAssertEqualObjects([[NSDate gh_tomorrow] gh_weekday:nil], @"Tomorrow", nil);
	GHAssertEqualObjects([[NSDate date] gh_weekday:nil], @"Today", nil);
	
	NSDate *date = [[NSDate date] gh_addDays:-3];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEEE"];
	NSString *weekday = [dateFormatter stringFromDate:date];
	GHAssertEqualObjects(weekday, [date gh_weekday:dateFormatter], nil);
}

- (void)testDate {
  NSInteger year = [[NSDate date] gh_year] - 1930;
  
  NSDate *date = [NSDate gh_dateWithDay:1 month:1 year:0 addDay:0 addMonth:0 addYear:-30 timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  NSString *dateString = [dateFormatter stringFromDate:date];
  NSString *expected = [NSString stringWithFormat:@"1/1/%ld", (long)year];
  GHAssertEqualStrings(dateString, expected, nil);
}

- (void)testComponents {
  NSDate *date = [NSDate gh_dateWithDay:1 month:2 year:2012 timeZone:nil];
  GHAssertTrue([date gh_day] == 1, nil);
  GHAssertTrue([date gh_month] == 2, nil);
  GHAssertTrue([date gh_year] == 2012, nil);
}

- (void)testMonthSymbolsForFormat {
  NSArray *monthSymbols = [NSDate gh_monthSymbols];
  GHTestLog([monthSymbols description]);
}

- (void)testMillisSince1970 {
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setDay:13];
	[comps setMonth:2];
	[comps setYear:2009];
	[comps setHour:23];
	[comps setMinute:31];
	[comps setSecond:30];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *date = [calendar dateFromComponents:comps];	
		
	long long millis = [date gh_millisSince1970];
	GHTestLog(@"millis=%lld", millis);
	GHAssertTrue(millis == 1234567890000, nil);
	
	NSNumber *millisNumber = [date gh_millisNumberSince1970];
	GHAssertEqualObjects(millisNumber, [NSNumber numberWithLongLong:1234567890000], nil);
}

@end