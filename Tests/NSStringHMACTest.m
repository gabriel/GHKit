//
//  NSString+HMACTest.m
//  GHKit
//
//  Created by Gabe on 7/2/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import "GHNSString+HMAC.h"
#import "GTMBase64.h"

@interface NSStringHMACTest : GHTestCase { }
@end

@implementation NSStringHMACTest

- (void)testHmacSha1 {  
  NSString *stringToSign = @"This is a test";  
  GHTestLog(@"String to sign: %@", stringToSign);
  NSString *secretKey = @"SECRETKEY";
  
  NSString *signature = [stringToSign gh_HMACSHA1:secretKey base64Encoder:[GTMBase64 class]];
  GHAssertEqualObjects(@"JHKEja4ahrNkMVyypQy/TLLkd48=", signature, @"HMAC SHA1 signature is not correct");
}

@end
