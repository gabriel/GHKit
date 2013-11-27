//
//  GHUIImage+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 11/26/13.
//  Copyright (c) 2013 rel.me. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface UIImage (GHUtils)

- (UIImage *)gh_imageFlippedHorizontal;

- (UIImage *)gh_imageMaskWithColor:(UIColor *)maskColor;

@end
