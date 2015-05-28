//
//  GHValidatorsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 10/1/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface GHValidatorsTest : XCTestCase { }
@end

@implementation GHValidatorsTest

- (void)testValidateEmail {
  XCTAssertTrue([GHValidators isEmailAddress:@"test@domain.com"]);
  XCTAssertFalse([GHValidators isEmailAddress:@"foo"]);
  XCTAssertFalse([GHValidators isEmailAddress:@""]);
  XCTAssertFalse([GHValidators isEmailAddress:nil]);
  XCTAssertFalse([GHValidators isEmailAddress:@"~gabrielh@gmail.com"]);
  XCTAssertTrue([GHValidators isEmailAddress:@"gabrielh@gmail.commmmmmm"]);
}

- (void)testValidateCreditCard {
  XCTAssertFalse([GHValidators isCreditCardNumber:@" "]);
  XCTAssertFalse([GHValidators isCreditCardNumber:@""]);
  XCTAssertFalse([GHValidators isCreditCardNumber:nil]);
  XCTAssertTrue([GHValidators isCreditCardNumber:@"49927398716"]);
  XCTAssertFalse([GHValidators isCreditCardNumber:@"1234"]);
  XCTAssertFalse([GHValidators isCreditCardNumber:@"abc"]);
}

- (void)testValidateCreditCardExpiration {
  NSDate *date = [NSDate gh_dateWithDay:1 month:12 year:2011 timeZone:nil];
  
  // Valid
  XCTAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date]);
  XCTAssertTrue([GHValidators isCreditCardExpiration:@"1/12" date:date]);
  XCTAssertTrue([GHValidators isCreditCardExpiration:@"1/2012" date:date]);
  XCTAssertTrue([GHValidators isCreditCardExpiration:@"01/12" date:date]);
  
  // Empty
  XCTAssertFalse([GHValidators isCreditCardExpiration:@" " date:date]);
  XCTAssertFalse([GHValidators isCreditCardExpiration:@"" date:date]);
  XCTAssertFalse([GHValidators isCreditCardExpiration:nil date:date]);

  // Expired but valid on the one day
  XCTAssertTrue([GHValidators isCreditCardExpiration:@"11/11" date:date]);
  NSDate *nextDay = [NSDate gh_dateWithDay:2 month:12 year:2011 timeZone:nil];
  XCTAssertFalse([GHValidators isCreditCardExpiration:@"11/11" date:nextDay]);
  
  // Invalid month or year
  XCTAssertFalse([GHValidators isCreditCardExpiration:@"13/12" date:date]);
  XCTAssertFalse([GHValidators isCreditCardExpiration:@"0/12" date:date]);
  
  // Expired
  XCTAssertFalse([GHValidators isCreditCardExpiration:@"1/2010" date:date]);
}

@end
