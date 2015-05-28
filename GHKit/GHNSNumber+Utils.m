//
//  GHNSNumber+Utils.m
//
//  Created by Gabe on 6/24/08.
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


#import "GHNSNumber+Utils.h"
#import "GHNSArray+Utils.h"


@implementation NSNumber(GHUtils)

- (NSString *)gh_humanSize {
  return [self gh_humanSizeWithDelimiter:@" "];
}

- (NSString *)gh_humanSizeWithDelimiter:(NSString *)delimiter {
  double value = [self doubleValue];
	double byteTest = 1024;
	double kilobyteTest = 1024 * byteTest;
	double megaByteTest = 1024 * kilobyteTest;
  
  if (value < byteTest) {
    return [NSString stringWithFormat:@"%.0f%@B", value, delimiter];
  } else if (value < kilobyteTest) {
    double d = value / byteTest;
    return [NSString stringWithFormat:@"%.0f%@KB", d, delimiter];
  } else if (value < megaByteTest) {
    double d = value / kilobyteTest;        
    return [NSString stringWithFormat:@"%.1f%@MB", d, delimiter];
  } else {
		double d = value / megaByteTest;
		return [NSString stringWithFormat:@"%.2f%@GB", d, delimiter];
  }
  return nil;
}

- (NSString *)gh_ordinalize {
  return [NSNumber gh_ordinalize:[self integerValue]];
}

- (NSString *)gh_ordinalizeMasculine:(BOOL)masculine {
  return [NSNumber gh_ordinalize:[self integerValue] masculine:masculine];
}

+ (NSString *)gh_ordinalizeEn:(NSInteger)value {
  NSString *suffix = nil;
  if (value > 0) {
    switch(value % 10) {
      case 1: suffix = @"st"; break;
      case 2: suffix = @"nd"; break;
      case 3: suffix = @"rd"; break;
      default: suffix = @"th"; break;
    }
    if (value % 100 >= 11 && value % 100 <= 13) suffix = @"th"; // Handle 11-13
    if (suffix) return [NSString stringWithFormat:@"%ld%@", (long)value, suffix];
  }
  return [NSString stringWithFormat:@"%ld", (long)value];
}

// NOTE(johnb): Ignoring plural forms of ordinals (ers / res / es)
+ (NSString *)gh_ordinalizeFr:(NSInteger)value masculine:(BOOL)masculine {
  NSString *suffix = nil;
  switch(value) {
    case 0: break;
    case 1: suffix = masculine ? @"er" : @"re"; break;
    default: suffix = @"e"; break;
  }
  if (suffix) return [NSString stringWithFormat:@"%ld%@", (long)value, suffix];
  return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)gh_ordinalizeDe:(NSInteger)value masculine:(BOOL)masculine {
  NSString *suffix = nil;
  switch (value) {
    case 0: break;
    default: suffix = masculine ? @"ter" : @"te"; break;
  }
  if (suffix) return [NSString stringWithFormat:@"%ld%@", (long)value, suffix];
  return [NSString stringWithFormat:@"%ld", (long)value];
}

// NOTE(johnb): Ignoring plural forms or ordinals (os / as)
+ (NSString *)gh_ordinalizeEs:(NSInteger)value masculine:(BOOL)masculine {
  NSString *suffix = nil;
  switch(value) {
    case 0: break;
    default: suffix = masculine ? @"º" : @"ª"; break;
  }
  if (suffix) return [NSString stringWithFormat:@"%ld%@", (long)value, suffix];
  return [NSString stringWithFormat:@"%ld", (long)value];
}

// The following OpenOffice wiki page is helpful for information about ordinals
// http://wiki.services.openoffice.org/wiki/Localized_AutoCorrection_of_Ordinal_Numbers_(1st_2nd)#French
+ (NSString *)gh_ordinalize:(NSInteger)value masculine:(BOOL)masculine {
  NSString *languageCode = [[NSLocale preferredLanguages] gh_firstObject];
  if ([languageCode isEqual:@"en"]) {
    return [NSNumber gh_ordinalizeEn:value];
  } else if ([languageCode isEqual:@"fr"]) {
    return [NSNumber gh_ordinalizeFr:value masculine:masculine];
  } else if ([languageCode isEqual:@"de"]) {
    return [NSNumber gh_ordinalizeDe:value masculine:masculine];
  } else if ([languageCode isEqual:@"es"]) {
    return [NSNumber gh_ordinalizeEs:value masculine:masculine];
  }
  return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)gh_ordinalize:(NSInteger)value {
  return [NSNumber gh_ordinalize:value masculine:YES];
}

+ (NSNumber *)gh_bool:(BOOL)b {		
  if (!b) {
		static NSNumber *NumberForNo = NULL;
    if (NumberForNo == NULL) NumberForNo = [NSNumber numberWithBool:NO];
    return NumberForNo;
  } else {
		static NSNumber *NumberForYes = NULL;
    if (NumberForYes == NULL) NumberForYes = [NSNumber numberWithBool:YES];
    return NumberForYes;
  }
}

+ (NSNumber *)gh_no {
  return [self gh_bool:NO];
}

+ (NSNumber *)gh_yes {
  return [self gh_bool:YES];
}

+ (NSInteger)gh_randomInteger {
	double r = (double)arc4random()/INT_MAX;
	return NSIntegerMax * r;
}

@end
