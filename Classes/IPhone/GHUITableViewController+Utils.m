//
//  GHUITableViewController+Utils.m
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/26/08.
//  Copyright 2008 Yelp. All rights reserved.
//

#import "GHUITableViewController+Utils.h"


@implementation UITableViewController (GHUtils)

- (void)gh_deselectRow {
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

@end
