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

@end