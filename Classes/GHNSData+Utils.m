//
//  GHNSData+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 1/14/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//

#import "GHNSData+Utils.h"
#import <arpa/inet.h>

@implementation NSData (GHUtils)

- (NSString *)gh_hexString {
  if ([self length] == 0) return nil;
  NSMutableString *hex = [NSMutableString stringWithCapacity:[self length] * 2];
  for (NSUInteger i = 0; i < [self length]; ++i) {
    [hex appendFormat:@"%02X", *((uint8_t *)[self bytes] + i)];
  }
  return hex;
}

- (NSString *)gh_IPAddressAsString {
  struct sockaddr *addr = (struct sockaddr*)[self bytes];
  if (addr->sa_family == AF_INET) {
    struct sockaddr_in *addr4 = (struct sockaddr_in*) addr;
    char addr4CString[INET_ADDRSTRLEN];
    if (!inet_ntop(AF_INET, &addr4->sin_addr, addr4CString, INET_ADDRSTRLEN)) {
      return nil;
    } else {
      return [[NSString alloc] initWithUTF8String:addr4CString];
    }
  } else if (addr->sa_family == AF_INET6) {
    struct sockaddr_in6* addr6 = (struct sockaddr_in6*) addr;
    char addr6CString[INET6_ADDRSTRLEN];
    if (!inet_ntop(AF_INET6, &addr6->sin6_addr, addr6CString, INET6_ADDRSTRLEN)) {
      return nil;
    } else {
      return [[NSString alloc] initWithUTF8String:addr6CString];
    }
  } else {
    return nil;
  }
}

@end
