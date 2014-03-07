GHKit
========

The GHKit framework is a set of extensions and utilities for Mac OS X and iOS.

Install (CocoaPods)
-------

1. Add `pod 'GHKit'` to your Podfile
1. Run `pod install`

See [CocoaPods](http://cocoapods.org/) for more details.

Usage
-----

GHKit defines various categories and general purpose utilities.

For example, parsing date strings, date math, string manipulations, URL dictionary formatting, etc. Some examples are below.

All categories are namespaced with gh_ to avoid conflicts.

***Import:***

```objc
#import <GHKit/GHKit.h>
```


***Dates:***

`GHNSDate+Formatters.h`: Date parsers, formatting and formatters for ISO8601, RFC822, HTTP (RFC1123, RFC850, asctime) and since epoch.

```objc
NSDate *date = [NSDate gh_parseISO8601:@"2010-10-07T04:25Z"];
NSString *dateString = [date gh_formatHTTP]; // Formatted like: Sun, 06 Nov 1994 08:49:37 GMT"
```

`GHNSDate+Utils.h`: For time ago in words and date component arithmentic (adding days), tomorrow, yesterday, and more.

```objc
NSDate *date = [NSDate date];
[date gh_isToday]; // YES
[[date gh_yesterday] gh_isToday]; // NO

date = [date gh_addDays:-1];
[date gh_wasYesterday]; // YES

[date gh_timeAgo:NO]; // @"1 day"
```


***Strings:***

`GHNSString+Utils.h`: Stripping, reversing, counting, UUID and more.

```objc
[NSString gh_isBlank:@"  "]; // YES
[NSString gh_isBlank:nil]; // YES
[@"abc" gh_reverse]; // @"cba" 
[@"  some text " gh_strip]; // @"some text"
[@" " gh_isPresent]; // NO
[@"abc" gh_isPresent]; // YES
[NSString gh_UUID]; // @"5A59DFDF-46BD-40D0-B065-%7D57A8407C4"
[@"ababababcde" gh_count:@"ab"]; // 4 (@"ab" appears 4 times)
```

***URLs:***

`GHNSURL+Utils.h`: Encoding, escaping, parsing, splitting out or sorting query params, and more.

```objc
NSDictionary *dict = [@"c=d&a=b" gh_queryStringToDictionary]; // Dictionary with a => b, c => d
[NSDictionary gh_dictionaryToQueryString:dict sort:YES]; // @"a=b&c=d"
```

***Colors:***

`GHUIColor+Utils.h`: Colors from hex, color space changes, darken.

```objc
UIColor *color = GHUIColorFromRGB(0xBC1128);
GH_HSV hsvColor = [color gh_hsv];
UIColor *darkenedColor = [color gh_darkenColor:0.1]; // Darken 10%
```

And more...
