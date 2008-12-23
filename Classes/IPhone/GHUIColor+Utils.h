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

- (GH_RGBA)gh_rgba;

- (GH_HSV)gh_hsv;

- (GH_HSV)gh_hsvFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

// See NSColor#getComponents:
- (void)gh_getComponents:(CGFloat *)components;

// See NSColor#numberOfComponents
- (NSInteger)gh_numberOfComponents;

// See NSColor#getRed:green:blue:alpha
- (void)gh_getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

@end
