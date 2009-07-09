//
//  GHNSObject+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 7/8/09.
//  Copyright 2009. All rights reserved.
//


@interface NSObject (GHUtils)

/*!
 Check if not equal to NSNull.
 Useful for checking nil and NSNull in a single expression:
 @code
 if ([foo gh_isNotNSNull]) { } // Will not evaluate if foo == nil or foo is equal to [NSNull null]
 @endcode
 */
- (BOOL)gh_isNotNSNull;

@end
