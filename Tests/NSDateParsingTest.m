//
//  NSDateParsingTest.m
//  GHKit
//
//  Created by Gabe on 6/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSDate+Formatters.h"

@interface NSDateParsingTest : GRTestCase { }
@end

@interface NSDate (Private)
- (id)initWithString:(NSString *)s;
@end

@implementation NSDateParsingTest

- (void)testFormatRFC822 {  
  NSString *rfc822 = @"Sun, 06 Nov 1994 08:49:37 +0000";
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  NSString *formatted = [date gh_formatRFC822];
  GRAssertEqualObjects(formatted, rfc822);
}

- (void)testParseHTTPDate {
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  
  NSString *rfc1123 = @"Sun, 06 Nov 1994 08:49:37 GMT"; //; RFC 822, updated by RFC 1123
  NSString *rfc850 = @"Sunday, 06-Nov-94 08:49:37 GMT"; //; RFC 850, obsoleted by RFC 1036
  NSString *ascTime = @"Sun Nov  6 08:49:37 1994"; //; ANSI C's asctime() format 
  
  NSDate *parsed = nil;
  
  parsed = [NSDate gh_parseHTTP:rfc1123];
  GRAssertEqualObjects(parsed, date);
  
  parsed = [NSDate gh_parseHTTP:rfc850];
  GRAssertEqualObjects(parsed, date);
  
  parsed = [NSDate gh_parseHTTP:ascTime];
  GRAssertEqualObjects(parsed, date);
}

- (void)testOffset {
  // Set local time zone to eastern time
  [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
  NSDate *date = [NSDate date];
  NSDate *newDate = [NSDate gh_parseTimeSinceEpoch:[NSNumber numberWithDouble:[date timeIntervalSince1970]] withDefault:nil offsetForTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
  // Times should be three hours (in seconds) apart
  GRAssertEqualsWithAccuracy(([newDate timeIntervalSince1970] - [date timeIntervalSince1970]), (3.0 * 60.0 * 60.0), 0.01);
}

- (void)testTimestamp {
  NSDate *date = [NSDate gh_parseTimeSinceEpoch:@(1234567890)];
  GRAssertEqualObjects(@(1234567890), [NSNumber numberWithUnsignedLongLong:[date timeIntervalSince1970]]);
}

- (void)testISO8601 {
  NSDate *date = [NSDate gh_parseISO8601:@"1997-07-16T19:20:30.045Z"];
  GRAssertEquals(869080830.045, [date timeIntervalSince1970]);
  
  NSDate *date2 = [NSDate gh_parseISO8601:@"1997-07-16T19:20:30Z"];
  GRAssertEquals((NSTimeInterval)869080830, [date2 timeIntervalSince1970]);
  
  NSDate *date3 = [NSDate gh_parseISO8601:@"2014-01-28T16:44:58-08:00"];
  GRAssertEquals((NSTimeInterval)1390956298, [date3 timeIntervalSince1970]);
  
  NSDate *date4 = [NSDate gh_parseISO8601:@"2014-01-28T16:44:58+01:00"];
  GRAssertEquals((NSTimeInterval)1390923898, [date4 timeIntervalSince1970]);
  
  NSDate *date5 = [NSDate gh_parseISO8601:@"2014-01-28T16:44:58.045+01:00"];
  GRAssertEquals((NSTimeInterval)1390923898.045, [date5 timeIntervalSince1970]);
}

@end
