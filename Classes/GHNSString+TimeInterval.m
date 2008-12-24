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

@implementation NSString (GHTimeInterval)

/*!
 @method gh_stringForTimeInterval
 @abstract Get time ago in words
 @param interval
 @param includeSeconds If YES, will say 'less than N seconds', otherwise will show 'less than a minute'
 @result Time ago in words
*/
+ (NSString *)gh_stringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds {
  NSTimeInterval intervalInSeconds = fabs(interval);
  double intervalInMinutes = round(intervalInSeconds/60.0);
  
  if (intervalInMinutes >= 0 && intervalInMinutes <= 1)
  {
    if (!includeSeconds) return intervalInMinutes <= 0 ? @"less than a minute" : @"1 minute";
    if (intervalInSeconds >= 0 && intervalInSeconds < 5) return @"less than 5 seconds";
    else if (intervalInSeconds >= 5 && intervalInSeconds < 10) return @"less than 10 seconds";
    else if (intervalInSeconds >= 10 && intervalInSeconds < 20) return @"less than 20 seconds";
    else if (intervalInSeconds >= 20 && intervalInSeconds < 40) return @"half a minute";
    else if (intervalInSeconds >= 40 && intervalInSeconds < 60) return @"less than a minute";
    else return @"1 minute";
  }
  else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) return [NSString stringWithFormat:@"%.0f minutes", intervalInMinutes];
  else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) return @"about 1 hour";
  else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) return [NSString stringWithFormat:@"about %.0f hours", round(intervalInMinutes/60.0)];
  else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) return @"1 day";
  else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) return [NSString stringWithFormat:@"%.0f days", round(intervalInMinutes/1440.0)];
  else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) return @"about 1 month";
  else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) return [NSString stringWithFormat:@"%.0f months", round(intervalInMinutes/43200.0)];
  else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) return @"about 1 year";
  else
    return [NSString stringWithFormat:@"over %.0f years", round(intervalInMinutes/525600.0)];    
}

@end
