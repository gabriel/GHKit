//
//  GHUIButton.m
//
//  Created by Gabriel Handford on 12/17/08.
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

#import "GHUIButton.h"
#import "GHCGUtils.h"
#import "GHUIColor+Utils.h"

@implementation GHUIButton

@synthesize title=title_, titleFont=titleFont_, strokeWidth=strokeWidth_, borderColor=borderColor_, etchedColor=etchedColor_, cornerRadius=cornerRadius_, 
color=color_, titleColor=titleColor_, alternateColor=alternateColor_, shadingType=shadingType_, 
highlightedColor=highlightedColor_, highlightedTitleColor=highlightedTitleColor_, highlightedAlternateColor=highlightedAlternateColor_, highlightedShadingType=highlightedShadingType_, 
disabledTitleColor=disabledTitleColor_, disabledColor=disabledColor_, disabledAlternateColor=disabledAlternateColor_, disabledShadingType=disabledShadingType_;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		self.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
		self.cornerRadius = 10.0;
		self.strokeWidth = 0.5;		
		
		self.borderColor = [UIColor blackColor];

		// Normal: Bluish text on white background
		self.titleColor = [UIColor colorWithRed:(CGFloat)(77.0/255.0) green:(CGFloat)(95.0/255.0) blue:(CGFloat)(154.0/255.0) alpha:(CGFloat)1.0];
		self.shadingType = GHUIButtonShadingTypeNone;
		self.color = [UIColor whiteColor];		
		
		// Highlighted: White text on gray linear shading
		self.highlightedTitleColor = [UIColor whiteColor];
		self.highlightedShadingType = GHUIButtonShadingTypeLinear;
		self.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
		self.highlightedAlternateColor = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
	}
	return self;
}

- (void)dealloc {
	[title_ release];
	[titleFont_ release];
	[titleColor_ release];
	[color_ release];
	[alternateColor_ release];
	[highlightedTitleColor_ release];
	[highlightedColor_ release];
	[highlightedAlternateColor_ release];
	[borderColor_ release];	
	[etchedColor_ release];
	[super dealloc];
}

+ (GHUIButton *)button {
	return [[[GHUIButton alloc] initWithFrame:CGRectZero] autorelease];
}

+ (GHUIButton *)blueButtonWithTitle:(NSString *)title frame:(CGRect)frame {
	GHUIButton *button = [[[GHUIButton alloc] initWithFrame:frame] autorelease];
	button.title = title;
	button.titleColor = [UIColor whiteColor];
	button.color = [UIColor colorWithRed:0.247 green:0.514 blue:0.953 alpha:1.0];
	button.alternateColor = [UIColor colorWithRed:0.114 green:0.333 blue:0.871 alpha:1.0];
	button.shadingType = GHUIButtonShadingTypeLinear;
	return button;	
}

+ (GHUIButton *)darkBlueButtonWithTitle:(NSString *)title frame:(CGRect)frame {
	GHUIButton *button = [[[GHUIButton alloc] initWithFrame:frame] autorelease];
	button.title = title;
	button.cornerRadius = 6.0;
	button.etchedColor = [UIColor blackColor];
	button.titleColor = [UIColor whiteColor];
	button.color = [UIColor colorWithRed:0.0 green:0.322 blue:0.8 alpha:1.0];
	button.alternateColor = [UIColor colorWithRed:0.0 green:0.059 blue:0.8 alpha:1.0];
	button.shadingType = GHUIButtonShadingTypeLinear;
	return button;
}

+ (GHUIButton *)blackButtonWithTitle:(NSString *)title frame:(CGRect)frame {
	GHUIButton *button = [[[GHUIButton alloc] initWithFrame:frame] autorelease];
	button.title = title;
	button.cornerRadius = 6.0;
	button.etchedColor = [UIColor darkGrayColor];
	button.titleColor = [UIColor whiteColor];
	button.shadingType = GHUIButtonShadingTypeHorizontalEdge;
	button.color = [UIColor blackColor];
	button.alternateColor = [UIColor blackColor];		
	return button;	
}

+ (GHUIButton *)grayButtonWithTitle:(NSString *)title frame:(CGRect)frame {
	GHUIButton *button = [[[GHUIButton alloc] initWithFrame:frame] autorelease];
	button.title = title;
	button.cornerRadius = 6.0;
	button.etchedColor = [UIColor whiteColor];
	button.titleColor = [UIColor grayColor];
	button.color = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
	button.alternateColor = [UIColor colorWithRed:0.796 green:0.796 blue:0.796 alpha:1.0];
	button.shadingType = GHUIButtonShadingTypeLinear;
	return button;
}


// For shading
typedef struct {
	CGFloat red1, green1, blue1, alpha1;
	CGFloat red2, green2, blue2, alpha2;
} _GHUIButtonTwoColors;

// Only uses main color
void _horizontalEdgeColorBlendFunction(void *info, const float *in, float *out) {
	_GHUIButtonTwoColors *twoColors = (_GHUIButtonTwoColors *)info;

	float v = *in;
	if (v < 0.5) {
		v = (v * 2.0) * 0.3 + 0.6222;
		*out++ = 1.0 - v + twoColors->red1 * v;
		*out++ = 1.0 - v + twoColors->green1 * v;
		*out++ = 1.0 - v + twoColors->blue1 * v;
		*out++ = 1.0 - v + twoColors->alpha1 * v;
	} else {
		*out++ = twoColors->red2;
		*out++ = twoColors->green2;
		*out++ = twoColors->blue2;
		*out++ = twoColors->alpha2;
	}
}

void _linearColorBlendFunction(void *info, const float *in, float *out) {
	_GHUIButtonTwoColors *twoColors = info;
	
	out[0] = (1.0 - *in) * twoColors->red1 + *in * twoColors->red2;
	out[1] = (1.0 - *in) * twoColors->green1 + *in * twoColors->green2;
	out[2] = (1.0 - *in) * twoColors->blue1 + *in * twoColors->blue2;
	out[3] = (1.0 - *in) * twoColors->alpha1 + *in * twoColors->alpha2;
}

void _colorReleaseInfoFunction(void *info) {
	free(info);
}

static const CGFunctionCallbacks linearFunctionCallbacks = {0, &_linearColorBlendFunction, &_colorReleaseInfoFunction};
static const CGFunctionCallbacks horizontalEdgeFunctionCallbacks = {0, &_horizontalEdgeColorBlendFunction, &_colorReleaseInfoFunction};

void DrawShading(CGContextRef context, UIColor *color, UIColor *alternateColor, CGSize size, GHUIButtonShadingType shadingType) {
	const CGFunctionCallbacks *callbacks;
	if (shadingType == GHUIButtonShadingTypeHorizontalEdge) {
		callbacks = &horizontalEdgeFunctionCallbacks;
	} else if (shadingType == GHUIButtonShadingTypeLinear) {
		callbacks = &linearFunctionCallbacks;
	} else {
		return;
	}
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

	_GHUIButtonTwoColors *twoColors = malloc(sizeof(_GHUIButtonTwoColors));
	[color gh_getRed:&twoColors->red1 green:&twoColors->green1 blue:&twoColors->blue1 alpha:&twoColors->alpha1];
	[alternateColor gh_getRed:&twoColors->red2 green:&twoColors->green2 blue:&twoColors->blue2 alpha:&twoColors->alpha2];
	
	static const float domainAndRange[8] = {0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0};
	
	CGFunctionRef blendFunctionRef = CGFunctionCreate(twoColors, 1, domainAndRange, 4, domainAndRange, callbacks);
	CGShadingRef shading = CGShadingCreateAxial(colorSpace, CGPointMake(0, 0), CGPointMake(0, size.height), blendFunctionRef, YES, YES);
	CGContextDrawShading(context, shading);
	CGShadingRelease(shading);
	CGFunctionRelease(blendFunctionRef);
	CGColorSpaceRelease(colorSpace);
}	

- (UIColor *)textColorForState:(UIControlState)state {
	if (highlightedTitleColor_ && (state == UIControlStateHighlighted)) {
		return highlightedTitleColor_;
	} else if (disabledTitleColor_ && (state == UIControlStateDisabled)) {
		return disabledTitleColor_;
	} else if (titleColor_) {
		return titleColor_;
	} else {
		return [UIColor blackColor];
	}
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();	
	
	UIControlState state = self.state;
	CGRect bounds = self.bounds;	
	CGSize size = bounds.size;
	
	BOOL isHighlighted = (state == UIControlStateHighlighted);
	BOOL isDisabled = (state == UIControlStateDisabled);
	
	GHUIButtonShadingType shadingType = shadingType_;
	UIColor *color = color_;
	UIColor *alternateColor = alternateColor_;
		
	if (isDisabled) {
		if (disabledShadingType_ != GHUIButtonShadingTypeUnknown) shadingType = disabledShadingType_;
		if (disabledColor_) color = disabledColor_;
		if (disabledAlternateColor_) alternateColor = disabledAlternateColor_;		
	} else if (isHighlighted || self.isTracking) {
		if (highlightedShadingType_ != GHUIButtonShadingTypeUnknown) shadingType = highlightedShadingType_;
		if (highlightedColor_) color = highlightedColor_;
		if (highlightedAlternateColor_) alternateColor = highlightedAlternateColor_;
	}
	
	UIColor *fillColor = color;
	
	if (color && shadingType != GHUIButtonShadingTypeNone) {
		GHContextAddRoundedRect(context, bounds, cornerRadius_, cornerRadius_, strokeWidth_);
		CGContextClip(context);
		DrawShading(context, color, alternateColor, self.bounds.size, shadingType);
		fillColor = nil;
	}
	
	GHContextDrawRoundedRect(context, bounds, [fillColor CGColor], [borderColor_ CGColor], strokeWidth_, cornerRadius_, cornerRadius_);
	
	CGColorRef textColor = [self textColorForState:state].CGColor;
	
	UIFont *font = titleFont_;
	if (!font) font = [UIFont boldSystemFontOfSize:14.0];
	
	NSArray *lines;
	
	if ([title_ gh_contains:@"\n" options:0]) {
		lines = [title_ componentsSeparatedByString:@"\n"];	
		
// // Auto wrapping; Untested
//	} else if (titleSize.height > size.height) {
//		lines = [NSMutableArray array];
//		NSMutableString *line = [NSMutableString string];
//		CGFloat currentWidth = 0;		
//		for(NSString *word in [title_ gh_cutWithString:@" " options:0]) {
//			CGSize wordSize = [word sizeWithFont:font];
//			if ((wordSize.width + currentWidth) > size.width) {
//				[lines addObject:line];
//				currentWidth = wordSize.width;
//				line = [NSMutableString stringWithString:word];			
//			} else {			
//				[line appendFormat:word];
//				currentWidth += wordSize.width;
//			}		
//		}
		
	} else {
		lines = [NSArray arrayWithObject:title_];
	}

	CGFloat lineHeight = font.pointSize;
	CGFloat lineGap = 4.0;
	CGFloat y = 0;
	
	// If we have more than 1 line calculate height based on lineHeight and gap
	// Otherwise use sizeWithFont (for better precision)
	if ([lines count] > 1) {
		y = size.height/2.0 - ((lineHeight * [lines count]) + (lineGap * ([lines count] - 1)))/2.0;	
	} else {
		CGSize titleSize = [title_ sizeWithFont:font];
		y = size.height/2.0 - titleSize.height/2.0;
	}
	
	for(NSString *line in lines) {
		CGSize lineSize = [line sizeWithFont:font];
		CGFloat x = size.width/2.0 - lineSize.width/2.0;
		
		if (etchedColor_ && !isHighlighted && !isDisabled) {
			CGContextSetFillColorWithColor(context, etchedColor_.CGColor);
			[line drawAtPoint:CGPointMake(x+1, y) forWidth:size.width withFont:font lineBreakMode:UILineBreakModeWordWrap];
		}
		
		CGContextSetFillColorWithColor(context, textColor);
		[line drawAtPoint:CGPointMake(x, y) forWidth:size.width withFont:font lineBreakMode:UILineBreakModeWordWrap];
		
		y += lineHeight + lineGap;
	}
}

#pragma mark Touch

- (void)_removeHighlight {
	self.highlighted = NO;
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {	
	self.highlighted = YES;
	[self setNeedsDisplay];
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _removeHighlight];
	[super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _removeHighlight];
	[super touchesCancelled:touches withEvent:event];
}

@end
