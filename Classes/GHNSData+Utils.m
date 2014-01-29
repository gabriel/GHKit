//
//  GHNSData+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 1/14/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//

#import "GHNSData+Utils.h"

@implementation NSData (GHUtils)

- (NSString *)gh_hexString {
  if ([self length] == 0) return nil;
  NSMutableString *hex = [NSMutableString stringWithCapacity:[self length] * 2];
  for (NSUInteger i = 0; i < [self length]; ++i) {
    [hex appendFormat:@"%02X", *((uint8_t *)[self bytes] + i)];
  }
  return hex;
}

@end
