//
//  GHNSDate+Parsing.m
//
//  Created by Gabe on 3/18/08.
//  Copyright 2008 Gabriel Handford
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

#import "GHNSDate+Parsing.h"

@implementation NSDate (GHParsing)

static NSDateFormatter *gh_is8601DateFormatter = nil;
static NSDateFormatter *gh_rfc822DateFormatter = nil;
static NSDateFormatter *gh_rfc1123DateFormatter = nil;
static NSDateFormatter *gh_rfc850DateFormatter = nil;
static NSDateFormatter *gh_ascTimeDateFormatter = nil;

/*!
*/
+ (NSDate *)gh_parseISO8601:(NSString *)dateString { 
  return [[self gh_iso8601DateFormatter] dateFromString:dateString];
}

/*!
 @method gh_parseRFC822
 @abstract Parse RFC822 encoded date
 @param dateString Date string to parse, eg. 'Wed, 01 Mar 2006 12:00:00 -0400'
 @result Date
*/
+ (NSDate *)gh_parseRFC822:(NSString *)dateString {
  return [[self gh_rfc822DateFormatter] dateFromString:dateString];
}

/*!
 @method gh_parseHTTP
 @abstract Parse http date, currently only handles RFC1123 date
 @param dateString Date string to parse
 
 HTTP-date    = rfc1123-date | rfc850-date | asctime-date
 
 Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
 Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
 Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format 
 */
+ (NSDate *)gh_parseHTTP:(NSString *)dateString {  
  NSDate *parsed = nil;
  parsed = [[self gh_rfc1123DateFormatter] dateFromString:dateString];
  if (parsed) return parsed;
  parsed = [[self gh_rfc850DateFormatter] dateFromString:dateString];
  if (parsed) return parsed;
  parsed = [[self gh_ascTimeDateFormatter] dateFromString:dateString];
  return parsed;
}

/*!
  @method gh_formatRFC822
  @abstract Get date formatted for RFC822
  @result The date string, like "Wed, 01 Mar 2006 12:00:00 -0400"
*/
- (NSString *)gh_formatRFC822 {
  return [[[self class] gh_rfc822DateFormatter] stringFromDate:self];
}

/*!
 @method gh_formatHTTP
 @abstract Get date formatted for RFC1123 (HTTP date)
 @result The date string, like "Sun, 06 Nov 1994 08:49:37 GMT"
*/
- (NSString *)gh_formatHTTP {
  return [[[self class] gh_rfc1123DateFormatter] stringFromDate:self];
}

/*! 
 @method gh_rfc822DateFormatter
 @abstract For example, Wed, 01 Mar 2006 12:00:00 -0400
 @result Date formatter for RFC822
*/
+ (NSDateFormatter *)gh_rfc822DateFormatter {  
  if (!gh_rfc822DateFormatter) {
    gh_rfc822DateFormatter = [[NSDateFormatter alloc] init];     
    [gh_rfc822DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 822 compatible
    [gh_rfc822DateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];    
    [gh_rfc822DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [gh_rfc822DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
  }
  
  return gh_rfc822DateFormatter;
}

/*!
 @method gh_iso8601DateFormatter
 @abstract For example, '2007-10-18T16:05:10.000Z'
 @result Date formatter for ISO8601
*/
+ (NSDateFormatter *)gh_iso8601DateFormatter {
  // Example: 2007-10-18T16:05:10.000Z  
  if (!gh_is8601DateFormatter) {
    gh_is8601DateFormatter = [[NSDateFormatter alloc] init];
    [gh_is8601DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 8601 compatible
    [gh_is8601DateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];    
    [gh_is8601DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [gh_is8601DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
  }
  return gh_is8601DateFormatter;
}

/*!
 @method gh_rfc1123DateFormatter
 @abstract For example, 'Wed, 01 Mar 2006 12:00:00 GMT'
 @result Date formatter for RFC1123
 */
+ (NSDateFormatter *)gh_rfc1123DateFormatter {
  // Example: "Wed, 01 Mar 2006 12:00:00 GMT"
  if (!gh_rfc1123DateFormatter) {
    gh_rfc1123DateFormatter = [[NSDateFormatter alloc] init];     
    [gh_rfc1123DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 822 compatible
    [gh_rfc1123DateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];    
    [gh_rfc1123DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [gh_rfc1123DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
  }
  
  return gh_rfc1123DateFormatter;
}

+ (NSDateFormatter *)gh_rfc850DateFormatter {
  // Example: Sunday, 06-Nov-94 08:49:37 GMT
  if (!gh_rfc850DateFormatter) {
    gh_rfc850DateFormatter = [[NSDateFormatter alloc] init];
    [gh_rfc850DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [gh_rfc850DateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [gh_rfc850DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [gh_rfc850DateFormatter setDateFormat:@"EEEE, dd-MMM-yy HH:mm:ss zzz"];
  }
  return gh_rfc850DateFormatter;
}

+ (NSDateFormatter *)gh_ascTimeDateFormatter {
  
  // Example: Sun Nov  6 08:49:37 1994
  if (!gh_ascTimeDateFormatter) {
    gh_ascTimeDateFormatter = [[NSDateFormatter alloc] init];
    [gh_ascTimeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [gh_ascTimeDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [gh_ascTimeDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [gh_ascTimeDateFormatter setDateFormat:@"EEE MMM d HH:mm:ss yyyy"];
  }  
  return gh_ascTimeDateFormatter;
}

@end
