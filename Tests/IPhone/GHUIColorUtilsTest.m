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

- (void)testHSB {
	UIColor *color = [[[UIColor alloc] initWithRed:0.20 green:0.4 blue:0.6 alpha:1.0] autorelease];
	GH_HSB hsb = [color hsb];
	// h=0.58, s=0.67, b=0.60 ??
}


- (void)testHSBRed {
	UIColor *color = [[[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] autorelease];
	GH_HSB hsb = [color hsb];
	NSLog(@"h=%0.2f, s=%0.2f, b=%0.2f", hsb.hue, hsb.saturation, hsb.brightness);
	// h=0.00, s=1.00, b=1.00
}



@end
