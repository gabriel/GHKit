//
//  GHReversableDictionaryTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/25/10.
//  Copyright 2010. All rights reserved.
//

#import "GHReversableDictionary.h"

@interface GHReversableDictionaryTest : GHTestCase { }
@end

@implementation GHReversableDictionaryTest

- (void)test {
  GHReversableDictionary *dict = [[[GHReversableDictionary alloc] initWithObjectsAndKeys:
                                   @"value1", @"key1",
                                   @"value2", @"key2",
                                   nil] autorelease];
  [dict setObject:@"value3" forKey:@"key3"];
  
  GHAssertEqualStrings([dict objectForKey:@"key1"], @"value1", nil);
  GHAssertEqualStrings([dict keyForObject:@"value1"], @"key1", nil);
  GHAssertEqualStrings([dict objectForKey:@"key3"], @"value3", nil);
  GHAssertEqualStrings([dict keyForObject:@"value3"], @"key3", nil);

}

@end
