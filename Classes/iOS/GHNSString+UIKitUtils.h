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

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

enum {
  GHNSStringAlignmentHorizontalCenter = 1 << 0,
  GHNSStringAlignmentVerticalCenter = 1 << 1,
};
typedef NSUInteger GHNSStringAlignment;

/*!
 Utilities for drawing strings in UIKit.
 @ingroup iPhone
 */
@interface NSString(GHUIKitUtils)

/*!
 Draw string in rect.
 Use alignment to specify to center horizontally, vertically, or both.
 */
- (void)gh_drawInRect:(CGRect)rect font:(UIFont *)font lineBreakMode:(UILineBreakMode)lineBreakMode 
            alignment:(GHNSStringAlignment)alignment;

/*!
 Draw string in rect, adjusting with minimum font size.
 Use alignment to specify to center horizontally, vertically, or both.
 */
- (void)gh_drawInRect:(CGRect)rect font:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize 
        lineBreakMode:(UILineBreakMode)lineBreakMode alignment:(GHNSStringAlignment)alignment;

@end
