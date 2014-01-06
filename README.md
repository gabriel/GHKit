GHKit
========

The GHKit framework is a set of extensions and utilities for Mac OS X and iOS.

Install (CocoaPods)
-------

1. Add `pod 'GHKit'` to your Podfile
1. Run `pod install`

See [CocoaPods](http://cocoapods.org/) for more details.


Documentation
--------

[API Docs](http://cocoadocs.org/docsets/GHKit)


Usage
-----

GHKit defines various categories and general purpose utilities.

For example, parsing date strings, generating time ago in words,
generating SHA1-HMAC, MD5, or special invocation proxies.

***Import:***

    #import <GHKit/GHKit.h>


***Dates:***

`GHNSDate+Formatters.h`: Date parsers, formatting and formatters for ISO8601, RFC822, HTTP (RFC1123, RFC850, asctime) and since epoch.

    NSDate *date = [NSDate gh_parseISO8601:@"2010-10-07T04:25Z"];
    NSString *dateString = [date gh_formatHTTP]; // Formatted like: Sun, 06 Nov 1994 08:49:37 GMT"


`GHNSDate+Utils.h`: For time ago in words and date component arithmentic (adding days), tomorrow, yesterday, and more.

    NSDate *date = [NSDate date];
    [date gh_isToday]; // YES
    [[date gh_yesterday] gh_isToday]; // NO

    date = [date gh_addDays:-1];
    [date gh_wasYesterday]; // YES

    [date gh_timeAgo:NO]; // @"1 day"


***Strings:***

`GHNSString+Utils.h`: Stripping, reversing, counting, UUID, MD5 and more.

     [NSString gh_isBlank:@"  "]; // YES
     [NSString gh_isBlank:nil]; // YES
     [@"abc" gh_reverse]; // @"cba" 
     [@"  some text " gh_strip]; // @"some text"

***URLs:***

`GHNSURL+Utils.h`: Encoding, escaping, parsing, splitting out or sorting query params, and more.

    NSDictionary *dict = [@"c=d&a=b" gh_queryStringToDictionary]; // Dictionary with a => b, c => d
    [NSDictionary gh_dictionaryToQueryString:dict sort:YES]; // @"a=b&c=d"


***Files:***

`GHNSFileManager+Utils.h`: File size, exists, generating temporary or unique file paths.


And more...
