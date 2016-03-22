//
//  UIColor+Utils.m
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

#import <math.h>

@implementation UIColor(GHUtils)

// From http://www.easyrgb.com/index.php?X=MATH&H=20#text20
+ (GH_HSV)gh_hsvFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
	
	float min = fminf(fminf(red, green), blue);
	float max = fmaxf(fmaxf(red, green), blue);
	float delta = max-min;

	float hue = 0.0;
	float saturation = 0.0;
	float value = max;
	
	if (delta <= 1.0E-5) {
		hue = 0.0;
		saturation = 0.0;
	} else {
		saturation = delta / max;
		
		float deltaR = (((max - red) / 6.0) + (max/2.0)) / delta;
		float deltaG = (((max - green) / 6.0) + (max/2.0)) / delta;
		float deltaB = (((max - blue) / 6.0) + (max/2.0)) / delta;
		
		if (red <= (max+1.0E-5) && red >= (max-1.0E-5)) hue = deltaB - deltaG;
		else if (green <= (max+1.0E-5)  && green >= (max-1.0E-5)) hue = (1.0/3.0) + deltaR - deltaB;
		else if (blue <= (max+1.0E-5) && blue >= (max-1.0E-5)) hue = (2.0/3.0) + deltaG - deltaR;
		
		if (hue < 0) hue += 1;
		if (hue > 1) hue -= 1;
	}	
	
	GH_HSV hsv;
	hsv.hue = hue;
	hsv.saturation = saturation;
	hsv.value = value;
	return hsv;
}

- (GH_RGBA)gh_rgba {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
  GH_RGBA color = { .red = 0, .green = 0, .blue = 0, .alpha = 1 };
	CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
	if (colorSpaceModel == kCGColorSpaceModelRGB) {
		color.red = components[0];
		color.green = components[1];
		color.blue = components[2];
		color.alpha = components[3];
	} else if (colorSpaceModel == kCGColorSpaceModelMonochrome) {
		color.red = components[0];
		color.green = components[0];
		color.blue = components[0];
		color.alpha = components[1];
	} else {
		NSAssert(NO, @"Unable to convert to RGBA from color space");
	}
	return color;
}

- (GH_HSV)gh_hsv {
	GH_RGBA rgba = [self gh_rgba];
	return [UIColor gh_hsvFromRed:rgba.red green:rgba.green blue:rgba.blue];
}

- (void)gh_getComponents:(CGFloat *)components {
	memcpy(components, CGColorGetComponents(self.CGColor), CGColorGetNumberOfComponents(self.CGColor) * sizeof(CGFloat));
}

- (NSInteger)gh_numberOfComponents {
	size_t num = CGColorGetNumberOfComponents(self.CGColor);
	return (NSInteger)num;
}

- (void)gh_getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	*red = *green = *blue = 0.0;
	*alpha = 1.0;
	size_t num = CGColorGetNumberOfComponents(self.CGColor);
	if (num <= 2) {
		*red = components[0];
		*green = components[0];
		*blue = components[0];
		if (num == 2) *alpha = components[1];
	} else if (num >= 3) {
		*red = components[0];
		*green = components[1];
		*blue = components[2];
		if (num >= 4) *alpha = components[3];
	}	
}

- (UIColor *)gh_darkenColor:(CGFloat)value {
  NSUInteger totalComponents = CGColorGetNumberOfComponents(self.CGColor);
  BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
  
  CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
  CGFloat newComponents[4];
  
  if(isGreyscale) {
    newComponents[0] = oldComponents[0] - value < 0.0f ? 0.0f : oldComponents[0] - value;
    newComponents[1] = oldComponents[0] - value < 0.0f ? 0.0f : oldComponents[0] - value;
    newComponents[2] = oldComponents[0] - value < 0.0f ? 0.0f : oldComponents[0] - value;
    newComponents[3] = oldComponents[1];
  }
  else {
    newComponents[0] = oldComponents[0] - value < 0.0f ? 0.0f : oldComponents[0] - value;
    newComponents[1] = oldComponents[1] - value < 0.0f ? 0.0f : oldComponents[1] - value;
    newComponents[2] = oldComponents[2] - value < 0.0f ? 0.0f : oldComponents[2] - value;
    newComponents[3] = oldComponents[3];
  }
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
  
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
  
  return retColor;
}


@end
