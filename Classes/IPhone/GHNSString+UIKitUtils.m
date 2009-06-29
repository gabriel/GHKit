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

@implementation NSString (GHUIKitUtils)

- (void)gh_drawAtCenter:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode 
								options:(GHNSStringDrawOptions)options {
	
	CGSize size = [self sizeWithFont:font forWidth:rect.size.width lineBreakMode:lineBreakMode];
	
	CGFloat x = rect.origin.x;
	CGFloat y = rect.origin.y;
	
	if (options == GHCenterHorizontal || options == GHCenterBoth) {
		CGFloat center = rect.size.width / 2.0 - size.width / 2.0;
		if (center >= 0) x += center;
	} 
	
	if (options == GHCenterVertical || options == GHCenterBoth) {
		CGFloat center = rect.size.height / 2.0 - size.height / 2.0;
		if (center >= 0) y += center;
	} 
	
	[self drawAtPoint:CGPointMake(x, y) forWidth:size.width withFont:font lineBreakMode:lineBreakMode];	
}

@end
