//
//  GHCGUtils.m
//
//  Created by Gabriel Handford on 12/30/08.
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


#import "GHCGUtils.h"


void GHContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerWidth, CGFloat cornerHeight, CGFloat strokeWidth) {	
	CGFloat fw, fh;
		
	// Stroke happens from the middle of the path; In order to prevent rounded corners from getting clipped
	// you need to inset by half the stroke amount.
	CGRect insetRect = CGRectInset(rect, strokeWidth/2.0, strokeWidth/2.0);
	
	CGContextBeginPath(context);
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, CGRectGetMinX(insetRect), CGRectGetMinY(insetRect));
	CGContextScaleCTM(context, cornerWidth, cornerHeight);
	fw = CGRectGetWidth(insetRect) / cornerWidth;
	fh = CGRectGetHeight(insetRect) / cornerHeight;
	CGContextMoveToPoint(context, fw, fh/2); 
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

void GHContextDrawRoundedRect(CGContextRef context, CGRect rect, CGColorRef fillColor, CGColorRef strokeColor, CGFloat strokeWidth, CGFloat cornerWidth, CGFloat cornerHeight) {
	
	if (fillColor != NULL) CGContextSetFillColorWithColor(context, fillColor);
	if (strokeColor != NULL) CGContextSetLineWidth(context, strokeWidth);
	
	CGContextSetStrokeColorWithColor(context, strokeColor);		
	GHContextAddRoundedRect(context, rect, cornerWidth, cornerHeight, strokeWidth);	
	if (strokeColor != NULL && fillColor != NULL) CGContextDrawPath(context, kCGPathFillStroke);
	else if (strokeColor == NULL && fillColor != NULL) CGContextDrawPath(context, kCGPathFill);
	else if (strokeColor != NULL && fillColor == NULL) CGContextDrawPath(context, kCGPathStroke);
}
