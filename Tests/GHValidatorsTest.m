//
//  GHValidatorsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 10/1/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHValidators.h"
#import "GHNSDate+Utils.h"


@interface GHValidatorsTest : GRTestCase { }
@end

@implementation GHValidatorsTest

- (void)testValidateEmail {
  GRAssertTrue([GHValidators isEmailAddress:@"test@domain.com"]);
  GRAssertFalse([GHValidators isEmailAddress:@"foo"]);
  GRAssertFalse([GHValidators isEmailAddress:@""]);
  GRAssertFalse([GHValidators isEmailAddress:nil]);
  GRAssertFalse([GHValidators isEmailAddress:@"~gabrielh@gmail.com"]);
  GRAssertTrue([GHValidators isEmailAddress:@"gabrielh@gmail.commmmmmm"]);
}

- (void)testValidateCreditCard {
  GRAssertFalse([GHValidators isCreditCardNumber:@" "]);
  GRAssertFalse([GHValidators isCreditCardNumber:@""]);
  GRAssertFalse([GHValidators isCreditCardNumber:nil]);
  GRAssertTrue([GHValidators isCreditCardNumber:@"49927398716"]);
  GRAssertFalse([GHValidators isCreditCardNumber:@"1234"]);
  GRAssertFalse([GHValidators isCreditCardNumber:@"abc"]);
}

- (void)testValidateCreditCardExpiration {
  NSDate *date = [NSDate gh_dateWithDay:1 month:12 year:2011 timeZone:nil];
  
  // Valid
  GRAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date]);
  GRAssertTrue([GHValidators isCreditCardExpiration:@"1/12" date:date]);
  GRAssertTrue([GHValidators isCreditCardExpiration:@"1/2012" date:date]);
  GRAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date]);
  
  // Empty
  GRAssertFalse([GHValidators isCreditCardExpiration:@" " date:date]);
  GRAssertFalse([GHValidators isCreditCardExpiration:@"" date:date]);
  GRAssertFalse([GHValidators isCreditCardExpiration:nil date:date]);

  // Expired but valid on the one day
  GRAssertTrue([GHValidators isCreditCardExpiration:@"11/11" date:date]);
  NSDate *nextDay = [NSDate gh_dateWithDay:2 month:12 year:2011 timeZone:nil];
  GRAssertFalse([GHValidators isCreditCardExpiration:@"11/11" date:nextDay]);
  
  // Invalid month or year
  GRAssertFalse([GHValidators isCreditCardExpiration:@"13/12" date:date]);
  GRAssertFalse([GHValidators isCreditCardExpiration:@"0/12" date:date]);
  
  // Expired
  GRAssertFalse([GHValidators isCreditCardExpiration:@"1/2010" date:date]);
}

@end
