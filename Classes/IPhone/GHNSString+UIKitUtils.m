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
	return [self gh_sizeWithFont:font forWidth:width lineGap:lineGap lines:nil maxLineCount:-1 truncated:nil options:0];
}

- (NSArray *)gh_linesWithFont:(UIFont *)font forWidth:(CGFloat)width maxLineCount:(NSInteger)maxLineCount truncated:(BOOL *)truncated options:(GHNSStringSizeOptions)options {
	NSArray *lines = nil;
	[self gh_sizeWithFont:font forWidth:width lineGap:0 lines:&lines maxLineCount:maxLineCount truncated:truncated options:options];
	return lines;
}

- (CGSize)gh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineGap:(CGFloat)lineGap 
										lines:(NSArray **)lines maxLineCount:(NSInteger)maxLineCount truncated:(BOOL *)truncated
									options:(GHNSStringSizeOptions)options {
	
	CGFloat originX = 0;
	CGFloat x = originX;
	CGFloat y = 0;
	CGFloat maxLineHeight = 0;
	CGFloat maxLineWidth = 0;
	
	NSMutableArray *wrappedLines = nil;
	NSMutableString *line = [NSMutableString string];
	if (truncated) *truncated = NO;
	
	for(NSString *word in [self gh_cutWithString:@" " options:0 cutAfter:NO]) {
		if ([word isEqualToString:@""]) continue;
		
		CGSize size = [word sizeWithFont:font];
		if (size.height > maxLineHeight) maxLineHeight = size.height;
		
		// If word does not fit on current line
		if (x + size.width > width) {			
			if (lines) {
				if (!wrappedLines) wrappedLines = [NSMutableArray array];
				
				BOOL hitMaxLineCount = (maxLineCount != -1 && ([wrappedLines count] + 1) >= maxLineCount);
				
				if (hitMaxLineCount) {					
					
					// If we are leaving some padding, then check and remove last 6 characters
					CGFloat paddingAmount = 40.0;
					NSInteger padCharacterCount = 6;
					if  (options & GHNSStringSizePad == GHNSStringSizePad) {
						if ((x + paddingAmount) > width) {
							if ([line length] > padCharacterCount) {
								[line deleteCharactersInRange:NSMakeRange([line length] - padCharacterCount, padCharacterCount)];
							} else {
								line = @"";
							}
						}
					}
						
					if  (options & GHNSStringSizeAddEllipsis == GHNSStringSizeAddEllipsis) [line appendString:@"…"];
					
					if (truncated) *truncated = YES;
					// Line will be added at the end for us
					break;
				}
				
				[wrappedLines addObject:line];
				line = [NSMutableString string];
			}
			
			x = originX;
			y += maxLineHeight + lineGap;
			maxLineHeight = size.height; // On new line the maxLineHeight defaults to the first word
			
			// Strip leading white space for word, if we are on a new line
			word = [word gh_leftStrip];
			size = [word sizeWithFont:font];			
		}
		
		if (lines) {
			[line appendString:word];
		}		
		
		x += size.width;
		if (x > maxLineWidth) maxLineWidth = x;
	}
	
	if (lines) {
		if ([line length] > 0) [wrappedLines addObject:line];
		*lines = wrappedLines;
	}
	
	return CGSizeMake(maxLineWidth, y + maxLineHeight);
}

- (void)gh_drawAtCenter:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode 
								options:(GHNSStringDrawOptions)options {
	
	CGSize size = [self sizeWithFont:font forWidth:rect.size.width lineBreakMode:lineBreakMode];
	
	CGFloat x = rect.origin.x;
	CGFloat y = rect.origin.y;
	
	if (options == GHCenterHorizontal || options == GHCenterBoth) {
		CGFloat center = rect.size.width / 2.0 - size.width / 2.0;
		if (center >= 0) x = center;
	} 
	
	if (options == GHCenterVertical || options == GHCenterBoth) {
		CGFloat center = rect.size.height / 2.0 - size.height / 2.0;
		if (center >= 0) y = center;
	} 
	
	[self drawAtPoint:CGPointMake(x, y) withFont:font];	
}

@end
