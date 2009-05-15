//
//  GHUITableViewStatusDelegate.h
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


/*!
 A table view (data source and view) delegate that shows an alternate view.
 This allows you to temporarily set your table view delegate to this special
 status delegate (that can show "Loading...", for example).

 Its a cool pattern originally from the Min Kim.
 
 Create the delegate with a view. GHUITableViewStatusView is an example status
 view with an activity indicator and loading label. You can create your own
 view; It just has to implement GHUITableViewStatusView protocol. 
 
 For example, in your UITableViewController subclass, create the GHUITableViewStatusDelegate:

 @code
	 GHUITableViewStatusView *statusView = [[GHUITableViewStatusView alloc] init];
   statusDelegate_ = [[GHUITableViewStatusDelegate alloc] initWithStatusView:statusView]; 
	 [statusView release];
 @endcode

 Then you can swap your existing table view delegate for the status delegate, and back again, while
 keeping your real datasource and view delegates from being polluted. Here is an example of what
 that might look like:

 @code
 - (void)setStatusDelegateEnabled:(BOOL)enabled {
   statusDelegate_.loading = enabled;
   if (enabled) {
			self.tableView.dataSource = statusDelegate_;
			self.tableView.delegate = statusDelegate_;		
			[self.tableView setUserInteractionEnabled:NO];
		} else {
			self.tableView.dataSource = self;
			self.tableView.delegate = self;		
			[self.tableView setUserInteractionEnabled:YES];
		}	
		[self.tableView reloadData];
 }
 @endcode
 TODO(gabe): This is obsoleted by YelpKit which is not released yet.
 @ingroup iPhone
 */


@protocol GHUITableViewStatusView <NSObject>
- (void)setText:(NSString *)text;
- (NSString *)text;
- (void)setLoading:(BOOL)loading;
- (BOOL)isLoading;
@end

@interface GHUITableViewStatusDelegate : NSObject <UITableViewDataSource, UITableViewDelegate> {
	
	UIView<GHUITableViewStatusView> *statusView_;
	UITableViewCell *statusCell_;
	
}

@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, retain) NSString *message;

- (id)initWithStatusView:(UIView<GHUITableViewStatusView> *)statusView;

@end


// An example status view you can use with the delegate above
@interface GHUITableViewStatusView : UIView <GHUITableViewStatusView> {
	
	UILabel *label_;	
	UIActivityIndicatorView *loadingIndicator_;
	
	NSString *text_;
	BOOL loading_;
	
}

@property (nonatomic, copy) NSString *text;

// If loading is set to YES, label text is set to text and animation is started.
// If loading is set to NO, label text is cleared and animation is stopped.
@property (nonatomic, assign, getter=isLoading) BOOL loading;

- (void)startAnimating;
- (void)stopAnimating;

@end
