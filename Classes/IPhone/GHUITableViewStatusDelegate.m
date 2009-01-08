//
//  GHUITableViewStatusDelegate.m
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

#import "GHUITableViewStatusDelegate.h"

#import "GHUITableViewCell.h"

@implementation GHUITableViewStatusDelegate

- (id)initWithStatusView:(UIView<GHUITableViewStatusView> *)statusView {
	if ((self = [super init])) {
		statusView_ = [statusView retain];
		statusCell_ = [[GHUITableViewCell alloc] initWithView:statusView_ reuseIdentifier:nil];
		statusCell_.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}

- (void)dealloc {
	[statusView_ release];
	[statusCell_ release];
	[super dealloc];
}

- (void)setMessage:(NSString *)message {
	[statusView_ setText:message];
}

- (NSString *)message {
	return [statusView_ text];
}

- (void)setLoading:(BOOL)loading {
	[statusView_ setLoading:loading];
}

- (BOOL)isLoading {
	return [statusView_ isLoading];
}

#pragma mark Delegates (UITableView)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return tableView.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
	return statusCell_;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { }

@end


@implementation GHUITableViewStatusView

@synthesize loading=loading_, text=text_;

- (id)init {
	if ((self = [super initWithFrame:CGRectZero])) {
		label_ = [[UILabel alloc] initWithFrame:CGRectZero];
		label_.font = [UIFont systemFontOfSize:16.0];
		label_.textColor = [UIColor colorWithRed:0.475 green:0.475 blue:0.475 alpha:1.0];
		label_.textAlignment = UITextAlignmentLeft;
		label_.text = text_;
		[self addSubview:label_];
		[label_ release];
		
		loadingIndicator_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loadingIndicator_.hidden = YES;
		[self addSubview:loadingIndicator_];
		[loadingIndicator_ release];
		
		self.text = @"Loading...";
	}
	return self;
}

- (void)layoutSubviews {	
	CGSize size = self.frame.size;

	CGSize labelFitSize = [label_ sizeThatFits:CGSizeMake(320, 20)];

	// Center text on view (according to preferred size); Leave room for loading indicator.
	CGFloat x = size.width / 2.0 - labelFitSize.width / 2.0;
	CGFloat y = size.height / 2.0 - labelFitSize.height / 2.0; 	
	
	label_.frame = CGRectMake(x + 10, y, labelFitSize.width, labelFitSize.height);	
	loadingIndicator_.frame = CGRectMake(x - 15, y, 20, 20);
}

- (void)startAnimating {
	loadingIndicator_.hidden = NO;
	[loadingIndicator_ startAnimating];
}

- (void)stopAnimating {
	[loadingIndicator_ stopAnimating];	
	loadingIndicator_.hidden = YES;
}

- (void)setLoading:(BOOL)loading {
	loading_ = loading;
	if (loading_) {
		label_.text = text_;
		[self startAnimating];
	} else {
		label_.text = nil;
		[self stopAnimating];
	}
	[self setNeedsLayout];
}

- (void)setText:(NSString *)text {
	[text retain];
	[text_ release];
	text_ = text;
	label_.text = text;
	[self setNeedsLayout];
}

@end

