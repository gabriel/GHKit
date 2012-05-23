//
//  GHNSDate+Formatters.m
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

#import "GHNSDate+Formatters.h"


@implementation NSDate(GHFormatters)

static NSDateFormatter *gRFC822DateFormatter = NULL;
static NSDateFormatter *gISO8601DateFormatter = NULL;
static NSDateFormatter *gRFC1123DateFormatter = NULL;
static NSDateFormatter *gRFC850DateFormatter = NULL;
static NSDateFormatter *gAscTimeDateFormatter = NULL;


+ (NSDate *)gh_parseISO8601:(NSString *)dateString { 
	if (!dateString) return nil;
  return [[self gh_ISO8601DateFormatter] dateFromString:dateString];
}

+ (NSDate *)gh_parseRFC822:(NSString *)dateString {
	if (!dateString) return nil;
  return [[self gh_RFC822DateFormatter] dateFromString:dateString];
}

+ (NSDate *)gh_parseHTTP:(NSString *)dateString {  
	if (!dateString) return nil;
  NSDate *parsed = nil;
  parsed = [[self gh_RFC1123DateFormatter] dateFromString:dateString];
  if (parsed) return parsed;
  parsed = [[self gh_RFC850DateFormatter] dateFromString:dateString];
  if (parsed) return parsed;
  parsed = [[self gh_ascTimeDateFormatter] dateFromString:dateString];
  return parsed;
}

+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch {
	return [self gh_parseTimeSinceEpoch:timeSinceEpoch withDefault:timeSinceEpoch];
}

+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch withDefault:(id)value {
  return [self gh_parseTimeSinceEpoch:timeSinceEpoch withDefault:value offsetForTimeZone:nil];
}

+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch withDefault:(id)value offsetForTimeZone:(NSTimeZone *)timeZone {
  if (!timeSinceEpoch) return value;
	NSDate *normalDate = [NSDate dateWithTimeIntervalSince1970:[timeSinceEpoch doubleValue]];
  if (!timeZone)
    return normalDate;
  NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
  if ([localTimeZone isEqualToTimeZone:timeZone])
    return normalDate;
  // The following adapted from http://stackoverflow.com/questions/1081647/how-to-convert-time-to-the-timezone-of-the-iphone-device/1082179#1082179
  NSInteger offset = [timeZone secondsFromGMTForDate:normalDate];
  NSInteger localOffset = [localTimeZone secondsFromGMTForDate:normalDate];
  NSTimeInterval difference = localOffset - offset;
  return [[[NSDate alloc] initWithTimeInterval:difference sinceDate:normalDate] autorelease];
}

- (NSString *)gh_formatRFC822 {
  return [[[self class] gh_RFC822DateFormatter] stringFromDate:self];
}

- (NSString *)gh_formatHTTP {
  return [[[self class] gh_RFC1123DateFormatter] stringFromDate:self];
}

- (NSString *)gh_formatISO8601 {
	return [[[self class] gh_ISO8601DateFormatter] stringFromDate:self];
}

+ (NSDateFormatter *)_gh_RFC822DateFormatter {
  NSDateFormatter *RFC822DateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [RFC822DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  // Need to force US locale when generating otherwise it might not be 822 compatible
  [RFC822DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];    
  [RFC822DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [RFC822DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
  return RFC822DateFormatter;
}

+ (NSDateFormatter *)gh_RFC822DateFormatter {
  if ([NSThread isMainThread]) {    
    if (gRFC822DateFormatter == NULL) gRFC822DateFormatter = [[self _gh_RFC822DateFormatter] retain];
    return gRFC822DateFormatter;
  }
  return [self _gh_RFC822DateFormatter];
}

+ (NSDateFormatter *)_gh_ISO8601DateFormatter {
  // Example: 2007-10-18T16:05:10.000Z  
  NSDateFormatter *ISO8601DateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [ISO8601DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  // Need to force US locale when generating otherwise it might not be 8601 compatible
  [ISO8601DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];    
  [ISO8601DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [ISO8601DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
  return ISO8601DateFormatter;
}

+ (NSDateFormatter *)gh_ISO8601DateFormatter {
  if ([NSThread isMainThread]) {
    if (gISO8601DateFormatter == NULL) gISO8601DateFormatter = [[self _gh_ISO8601DateFormatter] retain];
    return gISO8601DateFormatter;
  }
  return [self _gh_ISO8601DateFormatter];
}

+ (NSDateFormatter *)_gh_RFC1123DateFormatter {
  // Example: "Wed, 01 Mar 2006 12:00:00 GMT"
  NSDateFormatter *RFC1123DateFormatter = [[[NSDateFormatter alloc] init] autorelease];     
  [RFC1123DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  // Need to force US locale when generating otherwise it might not be 1123 compatible
  [RFC1123DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];    
  [RFC1123DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [RFC1123DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];	
  return RFC1123DateFormatter;
}

+ (NSDateFormatter *)gh_RFC1123DateFormatter {
  if ([NSThread isMainThread]) {
    if (gRFC1123DateFormatter == NULL) gRFC1123DateFormatter = [[self _gh_RFC1123DateFormatter] retain];
    return gRFC1123DateFormatter;
  }
  return [self _gh_RFC1123DateFormatter];
}

+ (NSDateFormatter *)_gh_RFC850DateFormatter {
  // Example: Sunday, 06-Nov-94 08:49:37 GMT
  NSDateFormatter *gh_rfc850DateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [gh_rfc850DateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  [gh_rfc850DateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
  [gh_rfc850DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [gh_rfc850DateFormatter setDateFormat:@"EEEE, dd-MMM-yy HH:mm:ss zzz"];
  return gh_rfc850DateFormatter;
}

+ (NSDateFormatter *)gh_RFC850DateFormatter {
  if ([NSThread isMainThread]) {
    if (gRFC850DateFormatter == NULL) gRFC850DateFormatter = [[self _gh_RFC850DateFormatter] retain];
    return gRFC850DateFormatter;
  }
  return [self _gh_RFC850DateFormatter];
}

+ (NSDateFormatter *)_gh_ascTimeDateFormatter {
  // Example: Sun Nov  6 08:49:37 1994
  NSDateFormatter *gh_ascTimeDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [gh_ascTimeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
  [gh_ascTimeDateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
  [gh_ascTimeDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [gh_ascTimeDateFormatter setDateFormat:@"EEE MMM d HH:mm:ss yyyy"];
  return gh_ascTimeDateFormatter;
}

+ (NSDateFormatter *)gh_ascTimeDateFormatter {
  if ([NSThread isMainThread]) {    
    if (gAscTimeDateFormatter == NULL) gAscTimeDateFormatter = [[self _gh_ascTimeDateFormatter] retain];
    return gAscTimeDateFormatter;
  }
  return [self _gh_ascTimeDateFormatter];
}

+ (void)gh_clearDateFormatterCaches {
  gRFC822DateFormatter = NULL;
  gISO8601DateFormatter = NULL;
  gRFC1123DateFormatter = NULL;
  gRFC850DateFormatter = NULL;
  gAscTimeDateFormatter = NULL;
}

@end
