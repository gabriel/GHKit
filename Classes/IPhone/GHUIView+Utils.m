//
//  GHUIView+Utils.m
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/21/08.
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

#import "GHUIView+Utils.h"


@implementation UIView (GHUtils)

- (NSInteger)gh_removeAllSubviews {
	NSInteger subviewCount = [self.subviews count];
	for(UIView *subview in self.subviews) {
		[subview removeFromSuperview];
	}
	return subviewCount;
}

- (void)gh_setHeight:(CGFloat)height {
	CGPoint origin = self.frame.origin;
	CGSize size = self.frame.size;
	self.frame = CGRectMake(origin.x, origin.y, size.width, height);
}

- (void)gh_setWidth:(CGFloat)width {
	CGPoint origin = self.frame.origin;
	CGSize size = self.frame.size;
	self.frame = CGRectMake(origin.x, origin.y, width, size.height);
}

- (void)gh_setSize:(CGSize)size {
	CGPoint origin = self.frame.origin;
	self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);	
}

- (void)gh_moveTo:(CGPoint)origin {
	CGSize size = self.frame.size;
	self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);	
}

- (UIView *)gh_setSizeToView:(UIView *)view {
	CGSize size = view.frame.size;
	self.frame = CGRectMake(0, 0, size.width, size.height);
	return self;
}


@end
