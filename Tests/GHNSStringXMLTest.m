//
//  GHNSStringXMLTest.m
//  GHKit
//
//  Created by Gabriel Handford on 4/5/10.
//  Copyright 2010. All rights reserved.
//


#import "GHNSString+XML.h"

@interface GHNSStringXMLTest : GRTestCase { }
@end

@implementation GHNSStringXMLTest

// TODO(gabe): Fix me
- (void)_test {
  NSString *escaped = [NSString gh_stringWithFormatForXML:@"Foo &amp; Bar = %@", @"Foo & Bar", nil];
  GRAssertEqualStrings(@"Foo &amp; Bar = Foo &amp; Bar", escaped);
}

@end
