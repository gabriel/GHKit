//
//  GHValidatorsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 10/1/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import "GHValidators.h"

@interface GHValidatorsTest : GHTestCase { }
@end

@implementation GHValidatorsTest

- (void)testValidateEmail {
  NSString *valid = @"test@domain.com";  
  GHAssertTrue([GHValidators isEmailAddress:valid], @"Should be valid email");
  
  NSString *invalid = @"foo";
  GHAssertFalse([GHValidators isEmailAddress:invalid], @"Should be invalid email");
  
  NSString *invalid2 = @"~gabrielh@gmail.com";  
  GHAssertFalse([GHValidators isEmailAddress:invalid2], @"Should be invalid email");
  
  NSString *valid3 = @"gabrielh@gmail.commmmmmm";  
  GHAssertTrue([GHValidators isEmailAddress:valid3], @"Should be valid email");
}

@end
