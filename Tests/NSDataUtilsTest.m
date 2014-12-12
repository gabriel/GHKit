//
//  NSDataUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/14/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSData+Utils.h"

@interface NSDataUtilsTest : GRTestCase { }
@end

@implementation NSDataUtilsTest

- (void)testHexString {
  NSString *testString = @"test string";
  NSData *data = [testString dataUsingEncoding:NSUTF8StringEncoding];
  GRAssertEqualStrings(@"7465737420737472696E67", [data gh_hexString]);
}

@end
