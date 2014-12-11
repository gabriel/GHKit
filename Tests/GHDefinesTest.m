//
//  GHDefinesTest.m
//  GHKit
//
//  Created by Gabriel on 10/23/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//


@interface GHDefinesTest : GRTestCase { }
@end

@implementation GHDefinesTest

- (void)testEquals {
  GRAssertTrue(GHEquals((id)nil, nil));
  GRAssertTrue(GHEquals(@(1), @(1)));
  GRAssertFalse(GHEquals((id)nil, @(1)));
  GRAssertFalse(GHEquals(@(1), nil));
}

- (void)testBase64 {
  GHBase64StringFromNSData([NSData data]);
  GHNSDataFromBase64String(@"");
}

@end
