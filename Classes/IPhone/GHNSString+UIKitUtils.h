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

@interface NSString (GHUIKitUtils)

/*!
 Size with font, using word wrap.
 
 The default sizeWithFont:forWidth:lineBreakMode: does not wrap text (and give
 you a sized height. This method does.
 
 @param font Font
 @param forWidth Width to wrap text on
 @param lineGap Gap height in between lines (height to append in between each line)
 */
- (CGSize)gh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineGap:(CGFloat)lineGap;

@end
