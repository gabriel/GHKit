//
//  GHUIAlertView+Utils.m
//  ShrubIPhone
//
//  Created by Gabriel Handford on 12/21/08.
//  Copyright 2008 Yelp. All rights reserved.
//

#import "GHUIAlertView+Utils.h"


@implementation UIAlertView (GHUtils)

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
	

@end
