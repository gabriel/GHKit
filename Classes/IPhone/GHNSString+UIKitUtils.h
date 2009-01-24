//
//  GHNSString+UIKitUtils.h
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

enum {
	GHTailTruncation = 1,
};
typedef NSUInteger GHNSStringSizeOptions;

enum {
	GHCenterHorizontal,
	GHCenterVertical,
	GHCenterBoth,
};
typedef NSUInteger GHNSStringDrawOptions;

@interface NSString (GHUIKitUtils)

/*!
 Size with font, using word wrap.
 
 The default sizeWithFont:forWidth:lineBreakMode: does not wrap text (and give
 you a sized height. This method does.
 
 @param font Font
 @param forWidth Width to wrap text on
 @param lineGap Gap height in between lines (height to append in between each line)
 @result Size to draw string
 */
- (CGSize)gh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineGap:(CGFloat)lineGap;

/*!
 Size with font, using word wrap.
 
 The default sizeWithFont:forWidth:lineBreakMode: does not wrap text (and give
 you a sized height. This method does.
 
 WARNING: maxLineCount only works when lines is not nil (TODO: Fix)
 
 @param font Font
 @param forWidth Width to wrap text on
 @param lineGap Gap height in between lines (height to append in between each line)
 @param lines If not nil, will set the word wrapped lines 
 @param maxLineCount Max number of lines
 @param truncated If not nil, will set to YES if we fit ok, or NO if we hit the max line count
 @param options Additional options on how to process and output
 @result Size to draw string
 */
- (CGSize)gh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineGap:(CGFloat)lineGap 
										lines:(NSArray **)lines maxLineCount:(NSInteger)maxLineCount truncated:(BOOL *)truncated
									options:(GHNSStringSizeOptions)options;

/*!
 Break string into lines.
 @param font Font
 @param forWidth Width to wrap text on
 @param maxLineCount Max number of lines
 @param truncated If not nil, will set to YES if we fit ok, or NO if we hit the max line count
 @param options Additional options on how to process and output
 */
- (NSArray *)gh_linesWithFont:(UIFont *)font forWidth:(CGFloat)width maxLineCount:(NSInteger)maxLineCount truncated:(BOOL *)truncated
											options:(GHNSStringSizeOptions)options;

/*!
 Draw string at center point of rect. Use options to specify to center horizontally, vertically, or both.
 */
- (void)gh_drawAtCenter:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode 
								options:(GHNSStringDrawOptions)options;

@end
