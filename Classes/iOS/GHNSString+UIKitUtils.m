//
//  GHNSString+UIKitUtils.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 1/8/09.
//  Copyright 2009 Gabriel Handford
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

#import "GHNSString+UIKitUtils.h"

@implementation NSString(GHUIKitUtils)

- (void)gh_drawInRect:(CGRect)rect font:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(GHNSStringAlignment)alignment {
	
	CGSize size = [self sizeWithFont:font forWidth:rect.size.width lineBreakMode:lineBreakMode];
	
	CGFloat x = rect.origin.x;
	CGFloat y = rect.origin.y;
  
	if ((alignment & GHNSStringAlignmentHorizontalCenter) == GHNSStringAlignmentHorizontalCenter) {
		CGFloat center = roundf((rect.size.width / 2.0) - (size.width / 2.0));
		if (center >= 0) x += center;
	} 
	
	if ((alignment & GHNSStringAlignmentVerticalCenter) == GHNSStringAlignmentVerticalCenter) {
		CGFloat center = roundf((rect.size.height / 2.0) - (size.height / 2.0));
		if (center >= 0) y += center;
	}
  
	[self drawAtPoint:CGPointMake(x, y) forWidth:size.width withFont:font lineBreakMode:lineBreakMode];	
}

- (void)gh_drawInRect:(CGRect)rect font:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize 
        lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(GHNSStringAlignment)alignment {
	
  if (!actualFontSize) {
    CGFloat fontSize;
    actualFontSize = &fontSize;
  }
  
	CGSize size = [self sizeWithFont:font minFontSize:minFontSize actualFontSize:actualFontSize 
                          forWidth:rect.size.width lineBreakMode:lineBreakMode];
	
	CGFloat x = rect.origin.x;
	CGFloat y = rect.origin.y;
  
	if ((alignment & GHNSStringAlignmentHorizontalCenter) == GHNSStringAlignmentHorizontalCenter) {
		CGFloat center = roundf((rect.size.width / 2.0) - (size.width / 2.0));
		if (center >= 0) x += center;
	} 
	
	if ((alignment & GHNSStringAlignmentVerticalCenter) == GHNSStringAlignmentVerticalCenter) {
		CGFloat center = roundf((rect.size.height / 2.0) - (size.height / 2.0));
		if (center >= 0) y += center;
	}
  
  UIFont *actualFont = [font fontWithSize:*actualFontSize];
	
	[self drawAtPoint:CGPointMake(x, y) forWidth:size.width withFont:actualFont lineBreakMode:lineBreakMode];	
}

@end
