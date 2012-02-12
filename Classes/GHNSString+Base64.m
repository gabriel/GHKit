//
//  GHNSString+Base64.m
//  GHKit
//
//  Created by Gabriel Handford on 2/11/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "GHNSString+Base64.h"

@implementation NSString(GHBase64)

- (NSString *)base64WithEncoder:(id)encoder {
  NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
  NSData *data = [(id<GHEncoder>)encoder encodeBytes:[stringData bytes] length:[stringData length]]; 
  return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

@end
