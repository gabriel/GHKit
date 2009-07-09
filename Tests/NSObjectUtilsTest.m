//
//  NSObjectUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/8/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSObject+Utils.h"

@interface NSObjectUtilsTest : GHTestCase { }
@end

@implementation NSObjectUtilsTest

- (void)testNotNSNull {
	id foo = nil;
	GHAssertFalse([foo gh_isNotNSNull], nil);
	foo = [NSNull null];
	GHAssertFalse([foo gh_isNotNSNull], nil);
	foo = @"1";
	GHAssertTrue([foo gh_isNotNSNull], nil);
}

@end