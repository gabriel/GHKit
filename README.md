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
NSDate *date = [NSDate gh_parseTimeSinceEpoch:@(1234567890)];
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

***Arrays:***

`GHNSArray+Utils.h`: Random object, safe object at index, uniq, compact

```objc
[@[@(1), @(2), @(3)] gh_random]; // Random object
[@[@(1), @(1), @(3)] gh_uniq]; // @[@(1), @(3)]
[@[] gh_objectAtIndex:0]; // nil (Safe objectAtIndex)
[@[@(1), NSNull.null] gh_compact]; // @[@(1)]
```

***Dictionaries:***

`GHDictionary+Utils.h`:

```objc
NSDictionary *dict = @{@"key1": @(2), @"key2": @(3.1), @"key3": @YES};
NSString *JSONString = [dict gh_toJSON:NSJSONWritingPrettyPrinted error:nil];
```

***Strings:***

`GHNSString+Utils.h`: Stripping, reversing, counting and more.

```objc
[NSString gh_isBlank:@"  "]; // YES
[NSString gh_isBlank:nil]; // YES
[@"  some text " gh_strip]; // @"some text"
[@" " gh_isPresent]; // NO
[@"abc" gh_isPresent]; // YES
[@" " gh_present]; // nil
[@"some text" gh_present]; // @"some text"

[@"abc" gh_reverse]; // @"cba"

[@"ababababcde" gh_count:@"ab"]; // 4 (@"ab" appears 4 times)

[NSString gh_localizedStringForTimeInterval:30]; // "half a minute"
[NSString gh_abbreviatedStringForTimeInterval:30]; // @"30s"

[@"WWW.test.com" gh_startsWith:@"www." options:NSCaseInsensitiveSearch]; // YES
[@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]; // @"bar"

[@"e̊gâds" gh_characters]; // @[@"e̊", @"g", @"â", @"d", @"s"];
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
