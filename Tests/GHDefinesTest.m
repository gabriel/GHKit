//
//  GHDefinesTest.m
//  GHKit
//
//  Created by Gabriel on 10/23/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface GHDefinesTest : XCTestCase { }
@end

@implementation GHDefinesTest

- (void)testEquals {
  XCTAssertTrue(GHEquals((id)nil, nil));
  XCTAssertTrue(GHEquals(@(1), @(1)));
  XCTAssertFalse(GHEquals((id)nil, @(1)));
  XCTAssertFalse(GHEquals(@(1), nil));
}

- (void)testBase64 {
  GHBase64StringFromNSData([NSData data]);
  GHNSDataFromBase64String(@"");
}

@end
