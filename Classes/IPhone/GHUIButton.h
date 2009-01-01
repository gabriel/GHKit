//
//  GHUIButton.h
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
// Portions adapted from:
// http://wilshipley.com/blog/2005/07/pimp-my-code-part-3-gradient.html
//

#import <Foundation/Foundation.h>

// Button shading types
typedef enum {
	GHUIButtonShadingTypeNone,
	GHUIButtonShadingTypeLinear,
	GHUIButtonShadingTypeHorizontalEdge
} GHUIButtonShadingType;
	

@interface GHUIButton : UIControl {

	NSString *_title;
	UIColor *_titleColor;
	UIFont *_titleFont;
	
	UIColor *_color;
	UIColor *_alternateColor;
	
	UIColor *_highlightedTitleColor;
	UIColor *_highlightedColor;
	UIColor *_highlightedAlternateColor;
	
	UIColor *_borderColor;
	
	CGFloat _strokeWidth;
	CGFloat _cornerRadius;
	
	GHUIButtonShadingType _shadingType;
	GHUIButtonShadingType _highlightedShadingType;
	
	BOOL _etchedTitle;
	
}

@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) UIFont *titleFont;

@property (retain, nonatomic) UIColor *titleColor;
@property (retain, nonatomic) UIColor *color;
@property (retain, nonatomic) UIColor *alternateColor;
@property (assign, nonatomic) GHUIButtonShadingType shadingType;

@property (retain, nonatomic) UIColor *highlightedTitleColor;
@property (retain, nonatomic) UIColor *highlightedColor;
@property (retain, nonatomic) UIColor *highlightedAlternateColor;
@property (assign, nonatomic) GHUIButtonShadingType highlightedShadingType;

@property (retain, nonatomic) UIColor *borderColor;

@property (assign, nonatomic) CGFloat strokeWidth;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (assign, nonatomic) BOOL etchedTitle;

+ (GHUIButton *)button;

// Button with white text on blue linear shaded background
+ (GHUIButton *)blueButtonWithTitle:(NSString *)title frame:(CGRect)frame;

// Button with white (etched) text on dark blue linear shaded background
+ (GHUIButton *)darkBlueButtonWithTitle:(NSString *)title frame:(CGRect)frame;

// Button with white text on black edge shaded background
+ (GHUIButton *)blackButtonWithTitle:(NSString *)title frame:(CGRect)frame;

@end
