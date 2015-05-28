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

// This might be tiff data?
- (NSData *)gh_data;

- (UIImage *)gh_imageByRotatingImageUpright;

- (UIImage *)gh_resizedImageInSize:(CGSize)size contentMode:(UIViewContentMode)contentMode opaque:(BOOL)opaque;

- (UIImage *)gh_croppedImageFromFrame:(CGRect)frame;

+ (UIImage *)gh_imageFromView:(UIView *)view;

+ (UIImage *)gh_imageFromDrawOperations:(void(^)(CGContextRef context))drawOperations size:(CGSize)size opaque:(BOOL)opaque;

- (UIImage *)gh_imageScaledToMaxWidth:(CGFloat)scaledToMaxWidth;

- (UIImage *)gh_imageScaledToWidth:(CGFloat)scaledToWidth;

@end
