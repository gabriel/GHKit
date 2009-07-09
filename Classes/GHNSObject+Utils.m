//
//  GHNSObject+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 7/8/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSObject+Utils.h"


@implementation NSObject (GHUtils)

- (BOOL)gh_isNotNSNull {
	return ![self isEqual:[NSNull null]];
}

@end
