//
//  UIColor+Utils.h
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/18/08.
//  Copyright 2008. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
} GH_RGBA;

// HSV is the same as HSB
typedef struct {
	float hue;
	float saturation;
	float value;
} GH_HSV;


@interface UIColor (GHUtils)

- (GH_RGBA)rgba;

- (GH_HSV)hsv;

- (GH_HSV)hsvFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

- (void)getComponents:(CGFloat *)components;

@end
