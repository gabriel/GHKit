//
//  NSString+HMACTest.m
//  GHKit
//
//  Created by Gabe on 7/2/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import "GHNSString+HMAC.h"

@interface NSStringHMACTest : GHTestCase { }
@end

@implementation NSStringHMACTest

- (void)testHmacSha1 {  
  NSString *signature1 = [@"what do ya want for nothing?" gh_HMACSHA1:@"Jefe"];
  GHTestLog(@"Signature #1: %@", signature1);
  GHAssertEqualObjects(@"7/zfauXrL6LSdBbV8YTfnCWafHk=", signature1, @"HMAC SHA1 signature is not correct");
  
  NSString *signature2 = [@"This is a test" gh_HMACSHA1:@"SECRETKEY"];
  GHTestLog(@"Signature #2: %@", signature2);
  GHAssertEqualObjects(@"14HjU+kYFlZuSlhgd0UVJWTM4+w=", signature2, @"HMAC SHA1 signature is not correct");
}

@end
