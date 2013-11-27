//
//  GHUIImage+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 11/26/13.
//  Copyright (c) 2013 rel.me. All rights reserved.
//

#import "GHUIImage+Utils.h"

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

@end