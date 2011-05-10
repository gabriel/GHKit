//
//  GHValidatorsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 10/1/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import "GHValidators.h"
#import "GHNSDate+Utils.h"


@interface GHValidatorsTest : GHTestCase { }
@end

@implementation GHValidatorsTest

- (void)testValidateEmail {
  GHAssertTrue([GHValidators isEmailAddress:@"test@domain.com"], @"Should be valid");
  GHAssertFalse([GHValidators isEmailAddress:@"foo"], @"Should be invalid");
  GHAssertFalse([GHValidators isEmailAddress:@""], @"Should be invalid");
  GHAssertFalse([GHValidators isEmailAddress:nil], @"Should be invalid");
  GHAssertFalse([GHValidators isEmailAddress:@"~gabrielh@gmail.com"], @"Should be invalid");
  GHAssertTrue([GHValidators isEmailAddress:@"gabrielh@gmail.commmmmmm"], @"Should be valid");
}

- (void)testValidateCreditCard {
  GHAssertFalse([GHValidators isCreditCardNumber:@" "], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardNumber:@""], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardNumber:nil], @"Should be invalid");
  GHAssertTrue([GHValidators isCreditCardNumber:@"49927398716"], @"Should be valid");
  GHAssertFalse([GHValidators isCreditCardNumber:@"1234"], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardNumber:@"abc"], @"Should be invalid");
}

- (void)testValidateCreditCardExpiration {
  NSDate *date = [NSDate gh_dateWithDay:1 month:12 year:2011 timeZone:nil];
  
  // Valid
  GHAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date], @"Should be valid");
  GHAssertTrue([GHValidators isCreditCardExpiration:@"1/12" date:date], @"Should be valid");
  GHAssertTrue([GHValidators isCreditCardExpiration:@"1/2012" date:date], @"Should be valid");
  GHAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date], @"Should be valid");
  
  // Empty
  GHAssertFalse([GHValidators isCreditCardExpiration:@" " date:date], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardExpiration:@"" date:date], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardExpiration:nil date:date], @"Should be invalid");

  // Expired but valid on the one day
  GHAssertTrue([GHValidators isCreditCardExpiration:@"11/11" date:date], @"Should be valid");
  NSDate *nextDay = [NSDate gh_dateWithDay:2 month:12 year:2011 timeZone:nil];
  GHAssertFalse([GHValidators isCreditCardExpiration:@"11/11" date:nextDay], @"Should be invalid");
  
  // Invalid month or year
  GHAssertFalse([GHValidators isCreditCardExpiration:@"13/12" date:date], @"Should be invalid");
  GHAssertFalse([GHValidators isCreditCardExpiration:@"0/12" date:date], @"Should be invalid");
  
  // Expired
  GHAssertFalse([GHValidators isCreditCardExpiration:@"1/2010" date:date], @"Should be invalid");
}

@end
