//
//  GHNSAttributedStringTest.m
//  GHKit
//
//  Created by Gabriel Handford on 4/9/11.
//  Copyright 2011. All rights reserved.
//

#import "GHNSAttributedString+Utils.h"

@interface GHNSAttributedStringTest : GHTestCase { }
@end

@implementation GHNSAttributedStringTest

- (void)test {
  NSURL *URL = [NSURL URLWithString:@"http://www.yelp.com"];
  NSAttributedString *attributedString = [NSAttributedString gh_linkFromString:@"Test" 
                                                                           URL:URL 
                                                                         color:[NSColor blueColor] 
                                                                  isUnderlined:NO]; 	
  GHTestLog(@"Attributed string: %@", attributedString);
}

@end
