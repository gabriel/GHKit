//
//  NSDateParsingTest.m
//  GHKit
//
//  Created by Gabe on 6/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import "GHNSDate+Formatters.h"

@interface NSDateParsingTest : GHTestCase { }
@end

@interface NSDate (Private)
- (id)initWithString:(NSString *)s;
@end

@implementation NSDateParsingTest

- (void)testFormatRFC822 {  
  NSString *rfc822 = @"Sun, 06 Nov 1994 08:49:37 +0000";
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  NSString *formatted = [date gh_formatRFC822];
  GHAssertEqualObjects(formatted, rfc822, @"Should conform to RFC822 date");  
}

- (void)testParseHTTPDate {
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  
  NSString *rfc1123 = @"Sun, 06 Nov 1994 08:49:37 GMT"; //; RFC 822, updated by RFC 1123
  NSString *rfc850 = @"Sunday, 06-Nov-94 08:49:37 GMT"; //; RFC 850, obsoleted by RFC 1036
  NSString *ascTime = @"Sun Nov  6 08:49:37 1994"; //; ANSI C's asctime() format 
  
  NSDate *parsed = nil;
  
  parsed = [NSDate gh_parseHTTP:rfc1123];
  GHAssertEqualObjects(parsed, date, @"Should conform to RFC1123 date");
  
  parsed = [NSDate gh_parseHTTP:rfc850];
  GHAssertEqualObjects(parsed, date, @"Should conform to RFC850/1036 date");
  
  parsed = [NSDate gh_parseHTTP:ascTime];
  GHAssertEqualObjects(parsed, date, @"Should conform to ASCTime date");
}

- (void)testOffset {
  // Set local time zone to eastern time
  [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
  NSDate *date = [NSDate date];
  NSDate *newDate = [NSDate gh_parseTimeSinceEpoch:[NSNumber numberWithDouble:[date timeIntervalSince1970]] withDefault:nil offsetForTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
  // Times should be three hours (in seconds) apart
  GHAssertEqualsWithAccuracy(([newDate timeIntervalSince1970] - [date timeIntervalSince1970]), (3.0 * 60.0 * 60.0), 0.01, nil);
}



@end
