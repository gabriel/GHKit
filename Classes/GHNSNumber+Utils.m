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

@implementation NSNumber (GHUtils)

/*!
 @method gh_humanSize
 @abstract File size label
 @result '904 b', '32 KB', '1.1 MB', 
 */
- (NSString *)gh_humanSize {
  return [self gh_humanSizeWithDelimiter:@" "];
}

/*!
 @method gh_humanSize
 @abstract File size label
 @param delimiter In between numeric and unit
 @result '904 b', '32 KB', '1.1 MB', 
 */
- (NSString *)gh_humanSizeWithDelimiter:(NSString *)delimiter {
  double num = [self doubleValue];
  double byteTest = 1024;
  double kilobyteTest = 1024 * byteTest;
  double megaByteTest = 1024 * kilobyteTest;
  double gigaByteTest = 1024 * megaByteTest;
  
  if (num < byteTest) {
    return [NSString stringWithFormat:@"%.0f%@B", num, delimiter];
  } else if (num < kilobyteTest) {
    num = num / byteTest;
    return [NSString stringWithFormat:@"%.0f%@KB", num, delimiter];
  } else if (num < megaByteTest) {
    num = num / kilobyteTest;        
    return [NSString stringWithFormat:@"%.1f%@MB", num, delimiter];
  } else if (num < gigaByteTest) {
    num = num / megaByteTest;
    return [NSString stringWithFormat:@"%.2f%@GB", num, delimiter];
  }
  return nil;
}

static NSNumber *gh_numberForNo;
static NSNumber *gh_numberForYes;

+ (NSNumber *)gh_bool:(BOOL)b {
  if (!b) {
    if (!gh_numberForNo) gh_numberForNo = [[NSNumber numberWithBool:NO] retain];
    return gh_numberForNo;
  } else {
    if (!gh_numberForYes) gh_numberForYes = [[NSNumber numberWithBool:YES] retain];
    return gh_numberForYes;
  }
}

+ (NSNumber *)gh_no {
  return [self gh_bool:NO];
}

+ (NSNumber *)gh_yes {
  return [self gh_bool:YES];
}

@end
