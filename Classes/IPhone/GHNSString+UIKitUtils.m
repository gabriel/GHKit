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

- (CGSize)gh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineGap:(CGFloat)lineGap {
	
	CGFloat originX = 0;
	CGFloat x = originX;
	CGFloat y = 0;
	CGFloat maxLineHeight = 0;
	CGFloat maxLineWidth = 0;
	
	for(NSString *word in [self gh_cutWithString:@" " options:0]) {
		if ([word isEqualToString:@""]) continue;
		
		CGSize size = [word sizeWithFont:font];
		if (size.height > maxLineHeight) maxLineHeight = size.height;
		
		// If word does not fit on current line
		if (x + size.width > width) {			
			x = originX;
			y += maxLineHeight + lineGap;
			maxLineHeight = size.height; // On new line the maxLineHeight defaults to the first word
		}
		
		x += size.width;
		if (x > maxLineWidth) maxLineWidth = x;
	}
	
	return CGSizeMake(maxLineWidth, y + maxLineHeight);
}

@end
