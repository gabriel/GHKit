//
//  GH_MAZeroingWeakRefTest.m
//  GHKit
//
//  Created by Gabriel Handford on 9/12/12.
//  Copyright (c) 2012 rel.me. All rights reserved.
//

#import "GH_MAZeroingWeakRef.h"


@interface GH_MAZeroingWeakRefTest : GHTestCase { }
@end

@implementation GH_MAZeroingWeakRefTest

- (void)test {
  NSObject *object = [[NSObject alloc] init];
  GH_MAZeroingWeakRef *weakRef = [GH_MAZeroingWeakRef refWithTarget:object];
  [object release];  
  [weakRef.target hash];
}

@end

