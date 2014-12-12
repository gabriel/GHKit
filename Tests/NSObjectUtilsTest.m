//
//  NSObjectUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/8/09.
//  Copyright 2009. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSObject+Utils.h"

@interface NSObjectUtilsTest : GRTestCase { }
@end

@implementation NSObjectUtilsTest

- (void)testNotNSNull {
	id foo = nil;
	GRAssertFalse([foo gh_isNotNSNull]);
	foo = [NSNull null];
	GRAssertFalse([foo gh_isNotNSNull]);
	foo = @"1";
	GRAssertTrue([foo gh_isNotNSNull]);
}

@end