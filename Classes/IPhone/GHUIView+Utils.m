//
//  GHUIView+Utils.m
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/21/08.
//  Copyright 2008 Yelp. All rights reserved.
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
