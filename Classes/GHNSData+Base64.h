//
//  GHNSData+Base64.h
//  GHKit
//
//  Created by Gabriel Handford on 2/11/12.
//  Copyright (c) 2012. All rights reserved.
//

/*!
 Utilities for generating a Base64 encoded string.
 */
@interface NSData(GHBase64)

/*!
 Base64 string.
 */
- (NSString *)gh_base64;

/*!
 Base64 string from bytes.
 */
+ (NSString *)gh_base64EncodeWithBytes:(const void *)bytes length:(NSUInteger)length;

@end
