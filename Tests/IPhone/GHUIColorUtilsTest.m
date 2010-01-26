//
//  GHUIColor+UtilsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/18/08.
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

#import "GHUIColor+Utils.h"
#import "GHKitDefines.h"

@interface GHUIColorUtilsTest : GHTestCase { }
@end

@implementation GHUIColorUtilsTest

- (void)testHSV {
	UIColor *color = [[[UIColor alloc] initWithRed:0.20 green:0.4 blue:0.6 alpha:1.0] autorelease];
	GH_HSV hsv = [color gh_hsv];
	// h=0.58, s=0.67, v=0.60
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.hue), @"0.58", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.saturation), @"0.67", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.value), @"0.60", @"Should match");
}


- (void)testHSVRed {
	UIColor *color = [[[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] autorelease];
	GH_HSV hsv = [color gh_hsv];
	// h=0.00, s=1.00, v=1.00
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.hue), @"0.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.saturation), @"1.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", hsv.value), @"1.00", @"Should match");
}

- (void)testGetComponents {
	CGFloat info[4];
	[[UIColor magentaColor] gh_getComponents:info];
	GHAssertEqualStrings(GHStr(@"%0.2f", info[0]), @"1.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", info[1]), @"0.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", info[2]), @"1.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", info[3]), @"1.00", @"Should match");
}

- (void)testGetRGB {
	CGFloat red, green, blue, alpha;
	[[UIColor magentaColor] gh_getRed:&red green:&green blue:&blue alpha:&alpha];
	GHAssertEqualStrings(GHStr(@"%0.2f", red), @"1.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", green), @"0.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", blue), @"1.00", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", alpha), @"1.00", @"Should match");	
	
	[[UIColor grayColor] gh_getRed:&red green:&green blue:&blue alpha:&alpha];
	GHAssertEqualStrings(GHStr(@"%0.2f", red), @"0.50", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", green), @"0.50", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", blue), @"0.50", @"Should match");
	GHAssertEqualStrings(GHStr(@"%0.2f", alpha), @"1.00", @"Should match");	
}

@end
