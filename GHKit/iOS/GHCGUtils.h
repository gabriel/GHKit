//
//  GHCGUtils.h
//  GHKit
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2013 Gabriel Handford. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

// Represents NULL point (CoreGraphics only has CGRectNull)
extern const CGPoint GHCGPointNull;

// Check if point is Null (CoreGraphics only has CGRectIsNull)
extern bool GHCGPointIsNull(CGPoint point);

// Represents NULL size (CoreGraphics only has CGRectNull)
extern const CGSize GHCGSizeNull;

// Check if size is Null (CoreGraphics only has CGRectIsNull)
extern bool GHCGSizeIsNull(CGSize size);

/*!
 Add rounded rect to current context path.
 @param context
 @param rect
 @param strokeWidth Width of stroke (so that we can inset the rect); Since stroke occurs from center of path we need to inset by half the strong amount otherwise the stroke gets clipped.
 @param cornerRadius Corner radius
 */
void GHCGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat strokeWidth, CGFloat cornerRadius);

/*!
 Draw rounded rect to current context.
 @param context
 @param rect
 @param fillColor If not NULL, will fill in rounded rect with color
 @param strokeColor Color of stroke
 @param strokeWidth Width of stroke
 @param cornerRadius Radius of rounded corners
 */
void GHCGContextDrawRoundedRect(CGContextRef context, CGRect rect, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius);

/*!
 Draw (fill and/or stroke) path.
 @param context
 @param path
 @param fillColor If not NULL, will fill in rounded rect with color
 @param strokeColor Color of stroke
 @param strokeWidth Width of stroke
 
 */
void GHCGContextDrawPath(CGContextRef context, CGPathRef path, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth);

/*!
 Create rounded rect path.
 @param rect
 @param strokeWidth Width of stroke
 @param cornerRadius Radius of rounded corners
 */
CGPathRef GHCGPathCreateRoundedRect(CGRect rect, CGFloat strokeWidth, CGFloat cornerRadius);

/*!
 Add line from (x, y) to (x2, y2) to context path.
 @param context
 @param x
 @param y
 @param x2
 @param y2
 */
void GHCGContextAddLine(CGContextRef context, CGFloat x, CGFloat y, CGFloat x2, CGFloat y2);

/*!
 Draw line from (x, y) to (x2, y2).
 @param context
 @param x
 @param y
 @param x2
 @param y2
 @param strokeColor Line color
 @param strokeWidth Line width (draw from center of width (x+(strokeWidth/2), y+(strokeWidth/2)))
 */
void GHCGContextDrawLine(CGContextRef context, CGFloat x, CGFloat y, CGFloat x2, CGFloat y2, CGColorRef strokeColor, CGFloat strokeWidth);

/*!
 Draws image inside rounded rect.
 
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param cornerRadius Corner radius for rounded rect
 @param contentMode Content Mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 */
void GHCGContextDrawRoundedRectImage(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius, UIViewContentMode contentMode, CGColorRef backgroundColor);

/*!
 Draws image inside rounded rect with a transform.
 
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param cornerRadius Corner radius for rounded rect
 @param contentMode Content Mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 @param transform The transform you want to apply to the image
 */
void GHCGContextDrawRoundedRectImageWithTransform(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius, UIViewContentMode contentMode, CGColorRef backgroundColor, CGAffineTransform transform);

/*!
 Draws image inside rounded rect with shadow.
 
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param cornerRadius Corner radius for rounded rect
 @param contentMode Content Mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 @param shadowColor Shadow color (or NULL)
 @param shadowBlur Shadow blur amount
 */
void GHCGContextDrawRoundedRectImageWithShadow(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius, UIViewContentMode contentMode, CGColorRef backgroundColor, CGColorRef shadowColor, CGFloat shadowBlur);

/*!
 Draws image inside rounded rect with shadow and transform.
 
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param cornerRadius Corner radius for rounded rect
 @param contentMode Content Mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 @param shadowColor Shadow color (or NULL)
 @param shadowBlur Shadow blur amount
 @param transform The transform you want to apply to the image
 */
void GHCGContextDrawRoundedRectImageWithShadowAndTransform(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius, UIViewContentMode contentMode, CGColorRef backgroundColor, CGColorRef shadowColor, CGFloat shadowBlur, CGAffineTransform transform);

/*!
 Draws image.
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param contentMode Content mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 */
void GHCGContextDrawImage(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, UIViewContentMode contentMode, CGColorRef backgroundColor);

/*!
 Draws image with transform.
 @param context Context
 @param image Image to draw
 @param imageSize Image size
 @param rect Rect to draw
 @param strokeColor Stroke color
 @param strokeWidth Stroke size
 @param contentMode Content mode
 @param backgroundColor If image is smaller than rect (and not scaling image), this background color is used.
 @param transform The transform you want to apply to the image
 */
void GHCGContextDrawImageWithTransform(CGContextRef context, CGImageRef image, CGSize imageSize, CGRect rect, CGColorRef strokeColor, CGFloat strokeWidth, UIViewContentMode contentMode, CGColorRef backgroundColor, CGAffineTransform transform);

/*!
 Figure out the rectangle to fit 'size' into 'inSize'.
 @param size
 @param inSize
 @param fill
 */
CGRect GHCGRectScaleAspectAndCenter(CGSize size, CGSize inSize, BOOL fill);

/*!
 Point to place region of size1 into size2, so that its centered.
 @param size1
 @param size2
 */
CGPoint GHCGPointToCenter(CGSize size1, CGSize size2);

/*!
 Point to place region of size1 into size2, so that its centered in Y position.
 */
CGPoint GHCGPointToCenterY(CGSize size, CGSize inSize);

/*!
 Returns if point is zero origin.
 */
BOOL GHCGPointIsZero(CGPoint p);

/*!
 Check if equal.
 @param p1
 @param p2
 */
BOOL GHCGPointIsEqual(CGPoint p1, CGPoint p2);

/*!
 Check if equal.
 @param size1
 @param size2
 */
BOOL GHCGSizeIsEqual(CGSize size1, CGSize size2);

/*!
 Check if size is zero.
 */
BOOL GHCGSizeIsZero(CGSize size);

/*!
 Check if equal within some accuracy.
 @param rect1
 @param rect2
 */
BOOL GHCGRectIsEqual(CGRect rect1, CGRect rect2);

/*!
 Returns a rect that is centered vertically in inRect but horizontally unchanged
 @param rect The inner rect
 @param inRect The rect to center inside of
 */
CGRect GHCGRectToCenterYInRect(CGRect rect, CGRect inRect);

/*!
 @deprecated Behavior of GHCGRectToCenterYInRect is more intuitive
 Returns a rect that is centered vertically in a region with the same size as inRect but horizontally unchanged
 @param rect The inner rect
 @param inRect The rect with the size to center inside of
 */
CGRect GHCGRectToCenterY(CGRect rect, CGRect inRect);

/*!
 TODO(gabe): Document
 */
CGPoint GHCGPointToRight(CGSize size, CGSize inSize);

/*!
 Center size in size.
 @param size Size for element to center
 @param inSize Containing size
 @result Centered on x and y, returning a size same as size (1st argument)
 */
CGRect GHCGRectCenterInSize(CGSize size, CGSize inSize);

BOOL GHCGSizeIsEmpty(CGSize size);

/*!
 TODO(gabe): Document
 */
CGRect GHCGRectToCenterInRect(CGSize size, CGRect inRect);

/*!
 TODO(gabe): Document
 */
CGFloat GHCGFloatToCenter(CGFloat length, CGFloat inLength, CGFloat min);

/*!
 Adds two rectangles.
 TODO(gabe): Document
 */
CGRect GHCGRectAdd(CGRect rect1, CGRect rect2);


/*!
 Get rect to right align width inside inWidth with maxWidth and padding on the right.
 */
CGRect GHCGRectRightAlign(CGFloat y, CGFloat width, CGFloat inWidth, CGFloat maxWidth, CGFloat padRight, CGFloat height);

/*!
 Right-align rect with inRect.
 If rect's width is larger than withRect, rect.origin.x will be smaller than withRect.origin.x.
 */
CGRect GHCGRectRightAlignWithRect(CGRect rect, CGRect withRect);

/*!
 Copy of CGRect with (x, y) origin set to 0.
 */
CGRect GHCGRectZeroOrigin(CGRect rect);

/*!
 Set size on rect.
 */
CGRect GHCGRectSetSize(CGRect rect, CGSize size);

/*!
 Set height on rect.
 */
CGRect GHCGRectSetHeight(CGRect rect, CGFloat height);

/*
 Set width on rect.
 */
CGRect GHCGRectSetWidth(CGRect rect, CGFloat width);

/*!
 Set x on rect.
 */
CGRect GHCGRectSetX(CGRect rect, CGFloat x);

/*!
 Set y on rect.
 */
CGRect GHCGRectSetY(CGRect rect, CGFloat y);


CGRect GHCGRectSetOrigin(CGRect rect, CGFloat x, CGFloat y);

CGRect GHCGRectSetOriginPoint(CGRect rect, CGPoint p);

CGRect GHCGRectOriginSize(CGPoint origin, CGSize size);

CGRect GHCGRectAddPoint(CGRect rect, CGPoint p);

CGRect GHCGRectAddHeight(CGRect rect, CGFloat height);

CGRect GHCGRectAddX(CGRect rect, CGFloat add);

CGRect GHCGRectAddY(CGRect rect, CGFloat add);

/*!
 Bottom right point in rect. (x + width, y + height).
 */
CGPoint GHCGPointBottomRight(CGRect rect);

/*!
 Center point in rect. (x + width / 2, y + height / 2).
 */
CGPoint GHCGPointCenter(CGRect rect);

CGFloat GHCGDistanceBetween(CGPoint pointA, CGPoint pointB);

/*!
 Returns a rect that is inset inside of size.
 */
CGRect GHCGRectWithInsets(CGSize size, UIEdgeInsets insets);

#pragma mark Border Styles

// Border styles:
// So far only borders for the group text field; And allow you to have top, middle, middle, middle, bottom.
//
//   GHUIBorderStyleNormal
//   -------
//   |     |
//   -------
//
//   GHUIBorderStyleRoundedTop:
//   ╭----╮
//   |     |
//
//
//   GHUIBorderStyleTopLeftRight
//   -------
//   |     |
//
//
//   GHUIBorderStyleRoundedBottom
//   -------
//   |     |
//   ╰----╯
//
typedef enum {
  GHUIBorderStyleNone = 0,
  GHUIBorderStyleNormal, // Top, right, botton, left
  GHUIBorderStyleTopOnly, // Top only
  GHUIBorderStyleBottomOnly, // Bottom only
  GHUIBorderStyleLeftOnly, // Left
  GHUIBorderStyleRightOnly, // Right only
  GHUIBorderStyleTopBottom, // Top and bottom only
  GHUIBorderStyleTopLeftRight, // Top, left and right sides (no bottom)
  GHUIBorderStyleBottomLeftRight, // Bottom, left and right sides (no top)

  GHUIBorderStyleRounded, // Rounded top, right, bottom, left
  GHUIBorderStyleRoundedTop, // Rounded top with left and right sides (no bottom)
  GHUIBorderStyleRoundedBottom, // Rounded bottom
  GHUIBorderStyleRoundedTopOnly, // Rounded top with no sides
  GHUIBorderStyleRoundedLeftCap, // Rounded left segment
  GHUIBorderStyleRoundedRightCap, // Rounded right segment
  GHUIBorderStyleRoundedBack, // Rounded back button
  GHUIBorderStyleRoundedTopWithBotton, // Rounded top with left and right sides (with bottom)
  GHUIBorderStyleRoundedBottomLeftRight, // Rounded bottom (no top)
  
} GHUIBorderStyle;

CGPathRef GHCGPathCreateStyledRect(CGRect rect, GHUIBorderStyle style, CGFloat strokeWidth, CGFloat cornerRadius);

/*!
 Check if border style is clippable.
 @return YES if border forms a connected path or we have a corner radius > 0
 */
BOOL GHIsBorderStyleClippable(GHUIBorderStyle borderStyle, CGFloat cornerRadius);

/*!
 Insets for border style and width.
 */
UIEdgeInsets GHBorderInsets(GHUIBorderStyle borderStyle, CGFloat borderWidth);

/*!
 Create path for line.
 @param x1
 @param y1
 @param x2
 @param y2
 */
CGPathRef GHCGPathCreateLine(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2);

void GHCGContextAddStyledRect(CGContextRef context, CGRect rect, GHUIBorderStyle style, CGFloat strokeWidth, CGFloat cornerRadius);

void GHCGContextDrawBorder(CGContextRef context, CGRect rect, GHUIBorderStyle style, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius);

void GHCGContextDrawBorderWithShadow(CGContextRef context, CGRect rect, GHUIBorderStyle style, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerRadius, CGColorRef shadowColor, CGFloat shadowBlur, BOOL saveRestore);

void GHCGContextDrawRect(CGContextRef context, CGRect rect, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth);

#pragma mark Colors

void GHCGColorGetComponents(CGColorRef color, CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha);

#pragma mark Shading

typedef enum {
  GHUIShadingTypeUnknown = -1,
  GHUIShadingTypeNone = 0,
  GHUIShadingTypeLinear, // Linear color blend (for color to color2)
  GHUIShadingTypeHorizontalEdge, // Horizontal edge (for color to color2 and color3 to color4)
  GHUIShadingTypeHorizontalReverseEdge, // Horizontal edge reversed
  GHUIShadingTypeExponential,
  GHUIShadingTypeMetalEdge,
} GHUIShadingType;

void GHCGContextDrawShadingWithHeight(CGContextRef context, CGColorRef color, CGColorRef color2, CGColorRef color3, CGColorRef color4, CGFloat height, GHUIShadingType shadingType);

void GHCGContextDrawShading(CGContextRef context, CGColorRef color, CGColorRef color2, CGColorRef color3, CGColorRef color4, CGPoint start, CGPoint end, GHUIShadingType shadingType,
                            BOOL extendStart, BOOL extendEnd);


/*!
 Convert rect for size with content mode.
 @param rect Bounds
 @param size Size of view
 @param contentMode Content mode
 */
CGRect GHCGRectConvert(CGRect rect, CGSize size, UIViewContentMode contentMode);

/*!
 Description for content mode.
 For debugging.
 */
NSString *GHNSStringFromUIViewContentMode(UIViewContentMode contentMode);

/*!
 Scale a CGRect's size while maintaining a fixed center point.
 @param rect CGRect to scale
 @param scale Scale factor by which to increaase the size of the rect
 */
CGRect GHCGRectScaleFromCenter(CGRect rect, CGFloat scale);


void GHCGTransformHSVRGB(float *components);
void GHTransformRGBHSV(float *components);

void GHCGContextDrawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor);

void GHCGContextDrawLinearGradientWithColors(CGContextRef context, CGRect rect, NSArray */*of CGColorRef*/colors, CGFloat *locations);

UIImage *GHCreateVerticalGradientImage(CGFloat height, CGColorRef topColor, CGColorRef bottomColor);


/*!
 Get a rounded corner mask. For example, for using as a CALayer mask.
 */
UIImage *GHCGContextRoundedMask(CGRect rect, CGFloat cornerRadius);

