//
//  NSDate+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 2/18/09.
//  Copyright 2009. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSDate+Utils.h"

@interface NSDateUtilsTest : GRTestCase { }
@end

@implementation NSDateUtilsTest

- (void)testYesterday {
	NSDate *date = [[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24)]; // This could fail daylight savings
	GRAssertTrue([date gh_wasYesterday]);
}

- (void)testTomorrow {
	NSDate *date = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24)]; // This could fail daylight savings
	GRAssertTrue([date gh_isTomorrow]);
}

- (void)testWeekday {
	GRTestLog(@"[NSDate gh_tomorrow]: %@", [NSDate gh_tomorrow]);
	GRAssertEqualObjects([[NSDate gh_yesterday] gh_weekday:nil], @"Yesterday");
	GRAssertEqualObjects([[NSDate gh_tomorrow] gh_weekday:nil], @"Tomorrow");
	GRAssertEqualObjects([[NSDate date] gh_weekday:nil], @"Today");
	
	NSDate *date = [[NSDate date] gh_addDays:-3];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEEE"];
	NSString *weekday = [dateFormatter stringFromDate:date];
	GRAssertEqualObjects(weekday, [date gh_weekday:dateFormatter]);
}

- (void)testDate {
  NSInteger year = [[NSDate date] gh_year] - 1930;
  
  NSDate *date = [NSDate gh_dateWithDay:1 month:1 year:0 addDay:0 addMonth:0 addYear:-30 timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  NSString *dateString = [dateFormatter stringFromDate:date];
  NSString *expected = [NSString stringWithFormat:@"1/1/%ld", (long)year];
  GRAssertEqualStrings(dateString, expected);
}

- (void)testComponents {
  NSDate *date = [NSDate gh_dateWithDay:1 month:2 year:2012 timeZone:nil];
  GRAssertTrue([date gh_day] == 1);
  GRAssertTrue([date gh_month] == 2);
  GRAssertTrue([date gh_year] == 2012);
}

- (void)testMonthSymbolsForFormat {
  NSArray *monthSymbols = [NSDate gh_monthSymbols];
  GRTestLog([monthSymbols description]);
}

@end