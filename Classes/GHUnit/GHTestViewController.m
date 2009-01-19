//
//  GHTestViewController.m
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
//  Copyright 2009. All rights reserved.
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

#import "GHTestViewController.h"


@implementation GHTestViewController

@synthesize splitView=splitView_, statusView=statusView_, detailsView=detailsView_;
@synthesize statusLabel=statusLabel_, progressIndicator=progressIndicator_, outlineView=outlineView_;
@synthesize detailsTextView=detailsTextView_;

- (id)init {
	if ((self = [super initWithNibName:@"GHTestView" bundle:nil])) {
		model_ = [[GHTestViewModel alloc] init];
	}
	return self;
}

- (void)dealloc {
	[model_ release];
	
	[splitView_ release];
	[statusView_ release];
	[detailsView_ release];
	[statusLabel_ release];
	[progressIndicator_ release];
	[outlineView_ release];
	[super dealloc];
}

- (void)awakeFromNib {
	[statusLabel_ setStringValue:@"Status: Loading tests..."];
	[detailsTextView_ setString:@""];
}

- (void)setStatus:(NSString *)status {
	[statusLabel_ setStringValue:[NSString stringWithFormat:@"Status: %@", status]];
}

- (NSString *)status {
	[NSException raise:NSGenericException format:@"Operation not supported"];
	return nil;
}

- (void)addTest:(GHTest *)test {
	GHAssertMainThread();
	self.status = [NSString stringWithFormat:@"%@", test.name];
	
	GHTestCaseItem *testCaseItem = nil;
	BOOL refreshRoot = NO;
	if (![model_ isCurrentTestCase:test.testCase]) {
		testCaseItem = [GHTestCaseItem testCaseItemWithTestCase:test.testCase];
		[model_ addTestCaseItem:testCaseItem];
		refreshRoot = YES;
	} else {
		testCaseItem = model_.currentTestCaseItem;
	}

	[testCaseItem addTestItem:[GHTestItem testItemWithTest:test]];
	if (refreshRoot) {
		[outlineView_ reloadItem:nil];
	} else {
		[outlineView_ reloadItem:testCaseItem reloadChildren:YES];
	}
}

- (void)testSuite:(GHTestSuite *)testSuite didUpdateTest:(GHTest *)test {	
	[progressIndicator_ setDoubleValue:((double)testSuite.runCount / (double)testSuite.totalCount)];
	GHTestItem *testItem = [model_ findTestItem:test];
	[outlineView_ reloadItem:testItem];
}

#pragma mark DataSource (NSOutlineView)

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
	if (!item) {
		return model_;
	} else {
		return [item objectAtIndex:index];
	}
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
	return (!item) ? YES : ([item numberOfChildren] > 0);
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
	return (!item) ? 1 : [item numberOfChildren];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
	if (!item) return nil;
	
	if ([[tableColumn identifier] isEqual:@"name"]) {
		return [item name];
	} else {
		return [item statusString];
	}
}

#pragma mark Delegates (NSOutlineView)

@end
