//
//  GHUIView+Utils.h
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/21/08.
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

#import <Foundation/Foundation.h>


@interface UIView (GHUtils)

- (NSInteger)gh_removeAllSubviews;

- (void)gh_setHeight:(CGFloat)height;
- (void)gh_setWidth:(CGFloat)width;
- (void)gh_setSize:(CGSize)size;
- (void)gh_moveTo:(CGPoint)origin;

/*!
 Sets the frame at (0, 0) with size based on the specified view size.
 @param view View to set size to
 @result Returns self
 */
- (UIView *)gh_setSizeToView:(UIView *)view;

@end
