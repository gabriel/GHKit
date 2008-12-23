//
//  GHUIColor+UtilsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/18/08.
//  Copyright 2008 Yelp. All rights reserved.
//

#import "GHUIColorUtilsTest.h"

@interface GHUIColorUtilsTest : GTMTestCase { }
@end

@implementation GHUIColorUtilsTest

- (void)testHSV {
	UIColor *color = [[[UIColor alloc] initWithRed:0.20 green:0.4 blue:0.6 alpha:1.0] autorelease];
	GH_HSV hsv = [color gh_hsv];
	// h=0.58, s=0.67, v=0.60
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.hue), @"0.58", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.saturation), @"0.67", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.value), @"0.60", @"Should match");
}


- (void)testHSVRed {
	UIColor *color = [[[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] autorelease];
	GH_HSV hsv = [color gh_hsv];
	// h=0.00, s=1.00, v=1.00
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.hue), @"0.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.saturation), @"1.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", hsv.value), @"1.00", @"Should match");
}

- (void)testGetComponents {
	CGFloat info[4];
	[[UIColor magentaColor] gh_getComponents:info];
	STAssertEqualStrings(GHStr(@"%0.2f", info[0]), @"1.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", info[1]), @"0.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", info[2]), @"1.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", info[3]), @"1.00", @"Should match");
}

- (void)testGetRGB {
	CGFloat red, green, blue, alpha;
	[[UIColor magentaColor] gh_getRed:&red green:&green blue:&blue alpha:&alpha];
	STAssertEqualStrings(GHStr(@"%0.2f", red), @"1.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", green), @"0.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", blue), @"1.00", @"Should match");
	STAssertEqualStrings(GHStr(@"%0.2f", alpha), @"1.00", @"Should match");	
}

@end
