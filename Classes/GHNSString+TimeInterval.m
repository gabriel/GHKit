//
//  GHNSString+TimeInterval.m
//
//  Created by Gabe on 6/6/08.
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

#import "GHNSString+TimeInterval.h"

#import <math.h>

@implementation NSString(GHTimeInterval)

#define GHIntervalLocalize(key, defaultValue) NSLocalizedStringWithDefaultValue(key, tableName, bundle, defaultValue, nil)

+ (NSString *)gh_stringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds {
	return [self gh_localizedStringForTimeInterval:interval includeSeconds:includeSeconds tableName:nil bundle:[NSBundle mainBundle]];
}

+ (NSString *)gh_localizedStringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds tableName:(NSString *)tableName bundle:(NSBundle *)bundle {
  NSTimeInterval intervalInSeconds = fabs(interval);
  double intervalInMinutes = round(intervalInSeconds/60.0);
  
  if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
    if (!includeSeconds) return intervalInMinutes <= 0 ? GHIntervalLocalize(@"LessThanAMinute", @"less than a minute") : GHIntervalLocalize(@"1Minute", @"1 minute");
    if (intervalInSeconds >= 0 && intervalInSeconds < 5) return [NSString stringWithFormat:GHIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 5];
    else if (intervalInSeconds >= 5 && intervalInSeconds < 10) return [NSString stringWithFormat:GHIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 10];
    else if (intervalInSeconds >= 10 && intervalInSeconds < 20) return [NSString stringWithFormat:GHIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 20];
    else if (intervalInSeconds >= 20 && intervalInSeconds < 40) return GHIntervalLocalize(@"HalfMinute", @"half a minute");
    else if (intervalInSeconds >= 40 && intervalInSeconds < 60) return GHIntervalLocalize(@"LessThanAMinute", @"less than a minute");
    else return GHIntervalLocalize(@"1Minute", @"1 minute");
  }
  else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) return [NSString stringWithFormat:GHIntervalLocalize(@"XMinutes", @"%.0f minutes"), intervalInMinutes];
  else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) return GHIntervalLocalize(@"About1Hour", @"about 1 hour");
  else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) return [NSString stringWithFormat:GHIntervalLocalize(@"AboutXHours", @"about %.0f hours"), round(intervalInMinutes/60.0)];
  else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) return GHIntervalLocalize(@"1Day", @"1 day");
  else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) return [NSString stringWithFormat:GHIntervalLocalize(@"XDays", @"%.0f days"), round(intervalInMinutes/1440.0)];
  else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) return GHIntervalLocalize(@"About1Month", @"about 1 month");
  else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) return [NSString stringWithFormat:GHIntervalLocalize(@"XMonths", @"%.0f months"), round(intervalInMinutes/43200.0)];
  else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) return GHIntervalLocalize(@"About1Year", @"about 1 year");
  else
    return [NSString stringWithFormat:GHIntervalLocalize(@"OverXYears", @"over %.0f years"), round(intervalInMinutes/525600.0)];    
}

@end
