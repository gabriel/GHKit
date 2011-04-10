//
//  GHNSStringXMLTest.m
//  GHKit
//
//  Created by Gabriel Handford on 4/5/10.
//  Copyright 2010. All rights reserved.
//


#import "GHNSString+XML.h"

@interface GHNSStringXMLTest : GHTestCase { }
@end

@implementation GHNSStringXMLTest

// TODO(gabe): Fix me
- (void)_test {
  NSString *escaped = [NSString gh_stringWithFormatForXML:@"Foo &amp; Bar = %@", @"Foo & Bar", nil];
  GHAssertEqualStrings(@"Foo &amp; Bar = Foo &amp; Bar", escaped, nil);
}

@end
