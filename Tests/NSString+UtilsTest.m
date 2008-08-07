//
//  NSStringUtilsTest.m
//  S3Share
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

#import "NSString+UtilsTest.h"

#import "GHNSString+Utils.h"
#import "GHNSString+Validation.h"

@implementation NSStringUtilsTest

- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  STAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}

- (void)testValidateEmail {
  NSString *valid = @"gabrielh@gmail.com";  
  STAssertTrue([valid gh_isEmailAddress], @"Should be valid email");
  
  NSString *invalid = @"foo";
  STAssertFalse([invalid gh_isEmailAddress], @"Should be invalid email");
  
  NSString *invalid2 = @"~gabrielh@gmail.com";  
  STAssertFalse([invalid2 gh_isEmailAddress], @"Should be invalid email");
  
  NSString *valid3 = @"gabrielh@gmail.commmmmmm";  
  STAssertTrue([valid3 gh_isEmailAddress], @"Should be valid email");
}

@end
