//
//  GHUIUtils.m
//  GHUIKit
//
//  Created by Gabriel Handford on 11/5/13.
//  Copyright (c) 2013 Gabriel Handford. All rights reserved.
//

#import "GHUIUtils.h"

@implementation GHUIUtils

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
  return [self sizeWithText:text font:font width:CGFLOAT_MAX];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
  return [self sizeWithText:text font:font width:width truncate:NO];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width truncate:(BOOL)truncate {
  return [self sizeWithText:text font:font size:(CGSize){width, CGFLOAT_MAX} truncate:truncate];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size {
  return [self sizeWithText:text font:font size:size truncate:NO];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size truncate:(BOOL)truncate {
  if (!text) return CGSizeZero;
  NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
  NSStringDrawingOptions options = 0;
  options |= NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
  if (truncate) options |= NSStringDrawingTruncatesLastVisibleLine;
  CGRect rect = [attributedText boundingRectWithSize:size options:options context:nil];
  return rect.size;
}

+ (NSInteger)fontSizeForText:(NSString *)text minFontSize:(NSInteger)minFontSize maxFontSize:(NSInteger)maxFontSize familyName:(NSString *)familyName size:(CGSize)size {
  if (maxFontSize < minFontSize) return maxFontSize;
  if (!text) return 0;

  NSInteger fontSize = roundf((float)(minFontSize + maxFontSize) / 2.0);

  UIFont *font = [UIFont fontWithName:familyName size:fontSize];
  CGSize textSize = [self sizeWithText:text font:font size:CGSizeMake(size.width, CGFLOAT_MAX)];

  if (textSize.height >= (size.height + 10) && textSize.width >= (size.width + 10) && textSize.height <= (size.height) && textSize.width <= (size.width) ) {
    return fontSize;
  } else if (textSize.height > size.height || textSize.width > size.width) {
    return [self fontSizeForText:text minFontSize:minFontSize maxFontSize:(fontSize - 1) familyName:familyName size:size];
  } else {
    return [self fontSizeForText:text minFontSize:(fontSize + 1) maxFontSize:maxFontSize familyName:familyName size:size];
  }
}

+ (void)drawText:(NSString *)text rect:(CGRect)rect font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment truncate:(BOOL)truncate {
  NSStringDrawingOptions options = 0;
  options |= NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
  if (truncate) options |= NSStringDrawingTruncatesLastVisibleLine;
  NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  [paragraphStyle setAlignment:alignment];
  [text drawWithRect:rect options:options attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:color} context:nil];
}

+ (UIView *)subview:(UIView *)view forClass:(Class)class {
  return [self _subview:view forClass:class iteration:0];
}

+ (UIView *)_subview:(UIView *)view forClass:(Class)class iteration:(NSInteger)iteration {
  if (iteration > 10) return nil;
  if ([view isKindOfClass:class]) return view;

  // Search breadth first since thats more likely
  for (UIView *subview in [view subviews]) {
    if ([subview isKindOfClass:class]) return subview;
  }
  ++iteration;
  for (UIView *subview in [view subviews]) {
    UIView *view = [GHUIUtils _subview:subview forClass:class iteration:iteration];
    if (view) return view;
  }
  return nil;
}

+ (NSMutableAttributedString *)joinAttributedStrings:(NSArray *)strings delimeter:(NSAttributedString *)delimeter {
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
  for (NSInteger index = 0; index < strings.count; index++) {
    NSAttributedString *as = strings[index];
    if (as.length > 0) {
      [text appendAttributedString:as];
      if (delimeter && index < strings.count - 1) {
        [text appendAttributedString:delimeter];
      }
    }
  }
  return text;
}

@end
