//
//  GHUIImage+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 11/26/13.
//  Copyright (c) 2013 rel.me. All rights reserved.
//

#import "GHUIImage+Utils.h"
#import "GHCGUtils.h"

@implementation UIImage (GHUtils)

- (UIImage *)gh_imageFlippedHorizontal {
  return [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)gh_imageMaskWithColor:(UIColor *)maskColor {
  CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
  
  UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  
  CGContextScaleCTM(ctx, 1.0f, -1.0f);
  CGContextTranslateCTM(ctx, 0.0f, -(imageRect.size.height));
  
  CGContextClipToMask(ctx, imageRect, self.CGImage);
  CGContextSetFillColorWithColor(ctx, maskColor.CGColor);
  CGContextFillRect(ctx, imageRect);
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

- (NSData *)gh_data {
  return (id)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage)));
}

+ (UIImage *)gh_imageFromDrawOperations:(void(^)(CGContextRef context))drawOperations size:(CGSize)size opaque:(BOOL)opaque {
  UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
  CGContextRef context = UIGraphicsGetCurrentContext();
  // Flip coordinate system, otherwise image will be drawn upside down
  CGContextTranslateCTM(context, 0, size.height);
  CGContextScaleCTM (context, 1.0, -1.0);
  drawOperations(context);
  UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return renderedImage;
}

+ (UIImage *)gh_imageFromView:(UIView *)view {
  [view setNeedsDisplay];
  UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
  CALayer *layer = view.layer;
  CGContextRef context = UIGraphicsGetCurrentContext();
  [layer renderInContext:context];
  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return viewImage;
}

- (UIImage *)gh_croppedImageFromFrame:(CGRect)frame {
  CGFloat scale = [self scale];
  frame.origin.x *= scale;
  frame.origin.y *= scale;
  frame.size.height *= scale;
  frame.size.width *= scale;
  return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.CGImage, frame) scale:scale orientation:self.imageOrientation];
}

- (UIImage *)gh_resizedImageInSize:(CGSize)size contentMode:(UIViewContentMode)contentMode opaque:(BOOL)opaque {
  CGRect imageRect = GHCGRectConvert(CGRectMake(0, 0, size.width, size.height), self.size, contentMode);
  
  UIImage *resizedImage = [UIImage gh_imageFromDrawOperations:^(CGContextRef context) {
    CGContextDrawImage(context, CGRectMake(0, 0, imageRect.size.width, imageRect.size.height), self.CGImage);
  } size:imageRect.size opaque:opaque];
  
  return resizedImage;
}

- (UIImage *)gh_imageByRotatingImageUpright {
  UIGraphicsBeginImageContextWithOptions(self.size, YES, self.scale);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  [self drawAtPoint:CGPointZero];
  
  if (self.imageOrientation == UIImageOrientationRight) {
    // Phone is upright
    CGContextRotateCTM (context, -M_PI_2);
  } else if (self.imageOrientation == UIImageOrientationLeft) {
    // Phone is upside down
    CGContextRotateCTM (context, M_PI_2);
  } else if (self.imageOrientation == UIImageOrientationDown) {
    // Phone is in landscape with the volume buttons facing up
    CGContextRotateCTM (context, M_PI);
  } else if (self.imageOrientation == UIImageOrientationUp) {
    // Phone is in landscape with the volume buttons facing down
  }
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}


@end