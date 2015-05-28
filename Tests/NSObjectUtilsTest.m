//
//  NSObjectUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/8/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSObjectUtilsTest : XCTestCase { }
@end

@implementation NSObjectUtilsTest

- (void)testNotNSNull {
	id foo = nil;
	XCTAssertFalse([foo gh_isNotNSNull]);
	foo = [NSNull null];
	XCTAssertFalse([foo gh_isNotNSNull]);
	foo = @"1";
	XCTAssertTrue([foo gh_isNotNSNull]);
}

@end