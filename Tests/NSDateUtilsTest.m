//
//  NSDate+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 2/18/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSDateUtilsTest : XCTestCase { }
@end

@implementation NSDateUtilsTest

- (void)testYesterday {
	NSDate *date = [[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24)]; // This could fail daylight savings
	XCTAssertTrue([date gh_wasYesterday]);
}

- (void)testTomorrow {
	NSDate *date = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24)]; // This could fail daylight savings
	XCTAssertTrue([date gh_isTomorrow]);
}

- (void)testWeekday {
	NSLog(@"[NSDate gh_tomorrow]: %@", [NSDate gh_tomorrow]);
	XCTAssertEqualObjects([[NSDate gh_yesterday] gh_weekday:nil], @"Yesterday");
	XCTAssertEqualObjects([[NSDate gh_tomorrow] gh_weekday:nil], @"Tomorrow");
	XCTAssertEqualObjects([[NSDate date] gh_weekday:nil], @"Today");
	
	NSDate *date = [[NSDate date] gh_addDays:-3];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEEE"];
	NSString *weekday = [dateFormatter stringFromDate:date];
	XCTAssertEqualObjects(weekday, [date gh_weekday:dateFormatter]);
}

- (void)testDate {
  NSInteger year = [[NSDate date] gh_year] - 1930;
  
  NSDate *date = [NSDate gh_dateWithDay:1 month:1 year:0 addDay:0 addMonth:0 addYear:-30 timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  NSString *dateString = [dateFormatter stringFromDate:date];
  NSString *expected = [NSString stringWithFormat:@"1/1/%ld", (long)year];
  XCTAssertEqualObjects(dateString, expected);
}

- (void)testComponents {
  NSDate *date = [NSDate gh_dateWithDay:1 month:2 year:2012 timeZone:nil];
  XCTAssertTrue([date gh_day] == 1);
  XCTAssertTrue([date gh_month] == 2);
  XCTAssertTrue([date gh_year] == 2012);
}

- (void)testMonthSymbolsForFormat {
  NSArray *monthSymbols = [NSDate gh_monthSymbols];
  NSLog(@"%@", [monthSymbols description]);
}

@end