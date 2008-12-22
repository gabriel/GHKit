//
//  GHUIView+Utils.h
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/21/08.
//  Copyright 2008 Yelp. All rights reserved.
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
