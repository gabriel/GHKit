//
//  GHUITableViewCell.h
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
 UITableViewCell that wraps a UIView.

 TODO(gabe): This is obsoleted by YelpKit which is not released yet.
 @ingroup iPhone
 */
@interface GHUITableViewCell : UITableViewCell { 
	UIView *cellView_;
}

@property (readonly, nonatomic) UIView *cellView;

/*!
 Create a cell from a UIView with reuse identifier.
 @param view View to use in cell. Cell is expanded to fill the view.
 @param reuseIdentifier Identifier for reuse
 @param target 
 @param accessoryAction
 */
- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier target:(id)target accessoryAction:(SEL)accessoryAction;

- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier;

// For UITableViewController with UITableViewStyleGrouped, this container will have a background.
// Calling this method will replace the background with a transparent one.
- (void)setTransparentBackground;

@end
