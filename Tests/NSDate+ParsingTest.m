//
//  NSDateParsingTest.m
//  GHKit
//
//  Created by Gabe on 6/30/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

#import "NSDate+ParsingTest.h"

#import "GHNSDate+Parsing.h"

@implementation NSDateParsingTest

- (void)testFormatRFC822 {  
  NSString *rfc822 = @"Sun, 06 Nov 1994 08:49:37 +0000";
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  NSString *formatted = [date gh_formatRFC822];
  STAssertEqualObjects(formatted, rfc822, @"Should conform to RFC822 date");  
}

- (void)testParseHTTPDate {
  NSDate *date = [[NSDate alloc] initWithString:@"1994-11-06 08:49:37 +0000"];
  
  NSString *rfc1123 = @"Sun, 06 Nov 1994 08:49:37 GMT"; //; RFC 822, updated by RFC 1123
  NSString *rfc850 = @"Sunday, 06-Nov-94 08:49:37 GMT"; //; RFC 850, obsoleted by RFC 1036
  NSString *ascTime = @"Sun Nov  6 08:49:37 1994"; //; ANSI C's asctime() format 
  
  NSDate *parsed = nil;
  
  parsed = [NSDate gh_parseHTTP:rfc1123];
  STAssertEqualObjects(parsed, date, @"Should conform to RFC1123 date");
  
  parsed = [NSDate gh_parseHTTP:rfc850];
  STAssertEqualObjects(parsed, date, @"Should conform to RFC850/1036 date");
  
  parsed = [NSDate gh_parseHTTP:ascTime];
  STAssertEqualObjects(parsed, date, @"Should conform to ASCTime date");
}

@end
