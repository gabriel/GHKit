//
//  UIColor+Utils.h
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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/*!
 Macro for UIColor from hex.
 UIColor *color = GHUIColorFromRGB(0xBC1128);
 */
#define GHUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/*!
 Represents an RGBA value.
 */
typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
} GH_RGBA;

/*!
 Represents an HSV value.
 
 HSV is the same as HSB.
 */
typedef struct {
	float hue;
	float saturation;
	float value;
} GH_HSV;


/*!
 Utilities for UIColor.
 
 @ingroup iPhone
 */
@interface UIColor(GHUtils)

/*!
 RGBA value.
 
 @result RGBA
 */
- (GH_RGBA)gh_rgba;

/*!
 HSV value.
 
 @result HSV
 */
- (GH_HSV)gh_hsv;

/*!
 HSV value from RGB.
 
 @param red Red
 @param green Green
 @param blue Blue
 @result HSV
 */
+ (GH_HSV)gh_hsvFromRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

// See NSColor#getComponents:
- (void)gh_getComponents:(CGFloat *)components;

// See NSColor#numberOfComponents
- (NSInteger)gh_numberOfComponents;

// See NSColor#getRed:green:blue:alpha
- (void)gh_getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

- (UIColor *)gh_darkenColor:(CGFloat)value;

@end
