//
//  NSString+HMACTest.m
//  GHKit
//
//  Created by Gabe on 7/2/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

#import "NSString+HMACTest.h"

#import "GHNSString+HMAC.h"

@implementation NSStringHMACTest

- (void)testHmacSha1 {  
  // Using S3 example from,
  // http://docs.amazonwebservices.com/AmazonS3/2006-03-01/RESTAuthentication.html
  
  NSString *stringToSign = @"GET\n\n\nTue, 27 Mar 2007 19:36:42 +0000\n/johnsmith/photos/puppy.jpg";  
  NSLog(@"String to sign: %@", stringToSign);
  NSString *secretKey = @"uV3F3YluFJax1cknvbcGwgjvx4QpvB+leU8dUj2o";
  
  NSString *signature = [stringToSign gh_hmacSha1:secretKey];
  GHAssertEqualObjects(@"xXjDGYUmKxnwqr5KXNPGldn5LbA=", signature, @"HMAC SHA1 signature is not correct");
}

@end
