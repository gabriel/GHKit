//
//  GHUITableViewCell.m
//
//  Created by Gabriel Handford on 1/7/09.
//  Copyright 2009 Gabriel Handford
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

#import "GHUITableViewCell.h"

@implementation GHUITableViewCell

@synthesize cellView=cellView_;

- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier {
	return [self initWithView:view reuseIdentifier:reuseIdentifier target:nil accessoryAction:nil];
}

- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier target:(id)target accessoryAction:(SEL)accessoryAction {
	if ((self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier])) {
		
		self.target = target;
		self.accessoryAction = accessoryAction;
		
		cellView_ = [view retain];
		cellView_.opaque = NO; // TODO(gabe): Check if we should alter the opaque here for sure
		[self.contentView addSubview:cellView_];
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		
		// Useful to set frame size to subview; So the table view delegate can use the cell frame size directly
		self.frame = CGRectMake(0, 0, cellView_.frame.size.width, cellView_.frame.size.height);					
	}
	return self;
}

- (void)setTransparentBackground {
	CGSize size = self.frame.size;
	UIView *transparentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)] autorelease];
	transparentView.opaque = NO;
	self.backgroundView = transparentView;	
	[transparentView release];
}

- (void)layoutSubviews {
	CGSize size = self.frame.size;
	cellView_.frame = CGRectMake(0, 0, size.width, size.height);
}

- (CGSize)sizeThatFits:(CGSize)size {
	return [cellView_ sizeThatFits:size];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	return [cellView_ hitTest:[self convertPoint:point toView:cellView_] withEvent:event];	
}

- (void)dealloc {
	[cellView_ release];
	[super dealloc];
}

@end

