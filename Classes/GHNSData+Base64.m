//
//  GHNSData+Base64.m
//  GHKit
//
//  Created by Gabriel Handford on 2/11/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "GHNSData+Base64.h"
#import "ybase64.h"

@implementation NSData(GHBase64)

- (NSString *)gh_base64 {
  return [NSData gh_base64EncodeWithBytes:self.bytes length:self.length];
}

+ (NSString *)gh_base64EncodeWithBytes:(const void *)bytes length:(NSUInteger)length {
  size_t len = ybase64_encode(bytes, length, NULL, 0);
  void * stringData = malloc(len);
  len = ybase64_encode(bytes, length, stringData, len);
  NSString * s = [NSString stringWithUTF8String:stringData];
  free(stringData);
  return s;
}

@end
