//
//  NSStringTimeIntervalTest.m
//
//  Created by Gabe on 6/6/08.
//  Copyright 2008 rel.me. Some rights reserved.
//

#import "GHNSString+TimeInterval.h"

@interface NSStringTimeIntervalTest : GRTestCase { }
@end

@implementation NSStringTimeIntervalTest

- (void)testStringForTimeInterval {
  GRAssertEqualObjects(@"less than a minute", [NSString gh_stringForTimeInterval:29.0 includeSeconds:NO], @"Invalid string for time interval");
  GRAssertEqualObjects(@"1 minute", [NSString gh_stringForTimeInterval:30.0 includeSeconds:NO], @"Invalid string for time interval");
  
  GRAssertEqualObjects(@"less than 5 seconds", [NSString gh_stringForTimeInterval:4.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"less than 10 seconds", [NSString gh_stringForTimeInterval:5.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"less than 20 seconds", [NSString gh_stringForTimeInterval:19.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"half a minute", [NSString gh_stringForTimeInterval:29.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"less than a minute", [NSString gh_stringForTimeInterval:59.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"1 minute", [NSString gh_stringForTimeInterval:60.0 includeSeconds:YES], @"Invalid string for time interval");
  
  GRAssertEqualObjects(@"1 minute", [NSString gh_stringForTimeInterval:89.0 includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"2 minutes", [NSString gh_stringForTimeInterval:90.0 includeSeconds:YES], @"Invalid string for time interval");
  
  GRAssertEqualObjects(@"44 minutes", [NSString gh_stringForTimeInterval:(44.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"about 1 hour", [NSString gh_stringForTimeInterval:(45.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"about 1 hour", [NSString gh_stringForTimeInterval:(89.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"about 2 hours", [NSString gh_stringForTimeInterval:(90.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"1 day", [NSString gh_stringForTimeInterval:(47.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"2 days", [NSString gh_stringForTimeInterval:(48.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"3 days", [NSString gh_stringForTimeInterval:(60.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"3 days", [NSString gh_stringForTimeInterval:(72.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"15 days", [NSString gh_stringForTimeInterval:(15.0 * 24.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"about 1 month", [NSString gh_stringForTimeInterval:(30.0 * 24.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"2 months", [NSString gh_stringForTimeInterval:(60.0 * 24.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  
  GRAssertEqualObjects(@"about 1 year", [NSString gh_stringForTimeInterval:(365.0 * 24.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
  GRAssertEqualObjects(@"over 2 years", [NSString gh_stringForTimeInterval:(2.0 * 365.0 * 24.0 * 60.0 * 60.0) includeSeconds:YES], @"Invalid string for time interval");
}

@end
