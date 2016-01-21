//
//  GHUIUtils.h
//  GHUIKit
//
//  Created by Gabriel Handford on 11/5/13.
//  Copyright (c) 2013 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GHUIUtils : NSObject

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width truncate:(BOOL)truncate;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size truncate:(BOOL)truncate;

+ (NSInteger)fontSizeForText:(NSString *)text minFontSize:(NSInteger)minFontSize maxFontSize:(NSInteger)maxFontSize familyName:(NSString *)familyName size:(CGSize)size;

+ (void)drawText:(NSString *)text rect:(CGRect)rect font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment truncate:(BOOL)truncate;

+ (UIView *)subview:(UIView *)view forClass:(Class)class;

+ (NSMutableAttributedString *)joinAttributedStrings:(NSArray *)strings delimeter:(NSAttributedString *)delimeter;

@end
