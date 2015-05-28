//
//  GHNSData+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 1/14/14.
//  Copyright (c) 2014 rel.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GHUtils)

/*!
 Return hex string for this data.
 */
- (NSString *)gh_hexString;

/*!
 Get IP address string from data object.
 */
- (NSString *)gh_IPAddressAsString;

@end
