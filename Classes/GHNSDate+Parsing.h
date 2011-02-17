//
//  GHNSDate+Parsing.h
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

/*! 
 Date parsers, formatting and formatters for ISO8601, RFC822, HTTP (RFC1123, RFC850, asctime) and since epoch.
 */
@interface NSDate(GHParsing)

/*!
 Parse ISO8601 date, for example, "2010-10-07T04:25Z".
 @param dateString
 @result Date
 */
+ (NSDate *)gh_parseISO8601:(NSString *)dateString;

/*!
 Parse RFC822 encoded date.
 @param dateString Date string to parse, eg. 'Wed, 01 Mar 2006 12:00:00 -0400'
 @result Date
*/
+ (NSDate *)gh_parseRFC822:(NSString *)dateString;

/*!
 Parse http date, currently only handles RFC1123 date.
 @param dateString Date string to parse
 
 @code
 HTTP-date    = rfc1123-date | rfc850-date | asctime-date
 
 Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
 Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
 Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format 
 @endcode
 */
+ (NSDate *)gh_parseHTTP:(NSString *)dateString;

/*!
 Parse time since epoch (1970) in seconds.
 @param timeSinceEpoch Seconds since Jan 1970 (epoch); An NSNumber or NSString (responds to doubleValue).
 @result NSDate or nil if timeSinceEpoch was nil
 */
+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch;

/*!
 Parse time since epoch (1970) in seconds, with default.
 @param timeSinceEpoch Seconds since Jan 1970 (epoch); An NSNumber or NSString (responds to doubleValue)
 @param withDefault Default if timeSinceEpoch is nil
 @result NSDate or default
 */
+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch withDefault:(id)value;

/*!
 Parse time since epoch (1970) in seconds.
 @param timeSinceEpoch Seconds since Jan 1970 (epoch); An NSNumber or NSString (responds to doubleValue)
 @param withDefault If timeSinceEpoch is nil, returns this value
 @param timeZone If set, the returned Date will be offset from the supplied timestamp by the difference between timeZone and the system time zone
 @result NSDate or nil if timeSinceEpoch was nil
 */
+ (NSDate *)gh_parseTimeSinceEpoch:(id)timeSinceEpoch withDefault:(id)value offsetForTimeZone:(NSTimeZone *)timeZone;

/*!
 Get date formatted for RFC822.
 @result The date string, like "Wed, 01 Mar 2006 12:00:00 -0400"
*/
- (NSString *)gh_formatRFC822;

/*!
 Get date formatted for RFC1123 (HTTP date).
 @result The date string, like "Sun, 06 Nov 1994 08:49:37 GMT"
*/
- (NSString *)gh_formatHTTP;

/*!
 Get date formatted for ISO8601 (XML date).
 @result The date string, like "2010-10-07T04:25Z"
 */
- (NSString *)gh_formatISO8601;

/*!
 For example, '2007-10-18T16:05:10.000Z'. Returns a new autoreleased formatter since NSDateFormatter is not thread-safe.
 @result Date formatter for ISO8601
*/
+ (NSDateFormatter *)gh_ISO8601DateFormatter;

/*! 
 For example, 'Wed, 01 Mar 2006 12:00:00 -0400'. Returns a new autoreleased formatter since NSDateFormatter is not thread-safe.
 @result Date formatter for RFC822
*/
+ (NSDateFormatter *)gh_RFC822DateFormatter;

/*!
 For example, 'Wed, 01 Mar 2006 12:00:00 GMT'. Returns a new autoreleased formatter since NSDateFormatter is not thread-safe.
 @result Date formatter for RFC1123
 */
+ (NSDateFormatter *)gh_RFC1123DateFormatter;

/*!
 For example, 'Sunday, 06-Nov-94 08:49:37 GMT'. Returns a new autoreleased formatter since NSDateFormatter is not thread-safe.
 @result Date formatter for RFC850
 */
+ (NSDateFormatter *)gh_RFC850DateFormatter;

/*!
 For example, 'Sun Nov  6 08:49:37 1994'. Returns a new autoreleased formatter since NSDateFormatter is not thread-safe.
 If this is called from the main thread, a cached date formatter is returned.
 @result Date formatter for asctime
 */
+ (NSDateFormatter *)gh_ascTimeDateFormatter;

/*!
 Clear any cached date formatters.
 */
+ (void)gh_clearDateFormatterCaches;

@end
