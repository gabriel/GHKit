//
//  GHNSString+Base64.h
//  GHKit
//
//  Created by Gabriel Handford on 2/11/12.
//  Copyright (c) 2012. All rights reserved.
//

/*!
 Protocol for a Base64 encoder required by GHKit.
 */
@protocol GHEncoder
- (NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
@end

/*!
 Utilities for generating a Base64 encoded string.
 */
@interface NSString(GHBase64)

/*!
 Base64.
 
 For the Base64 encoder you can user GTMBase64, or that implements:
 
      - (NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
 
 For example,
 
      #import <GHKit/GTMBase64.h>
      ["stringtosign" base64WithEncoder:[GTMBase64 class]];
 
 @param encoder Base64 encoder, that implements: (NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
 @result Base64 encoded
 */
- (NSString *)base64WithEncoder:(id)encoder;

@end
