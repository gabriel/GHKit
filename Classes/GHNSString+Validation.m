//
//  GHNSString+Validation.m
//  S3Hub
//
//  Created by Gabe on 7/20/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

#import "GHNSString+Validation.h"

#import "GTMRegex.h"

@implementation NSString (GHValidation)

- (BOOL)gh_isEmailAddress {
  // Simple regex from http://www.regular-expressions.info/email.html
  NSString *emailRegexPattern = @"^[A-Z0-9._%+-\\'\"]+@[A-Z0-9.-]+\\.[A-Z]+$";  
  GTMRegex *regex = [GTMRegex regexWithPattern:emailRegexPattern options:kGTMRegexOptionIgnoreCase];  
  return [regex matchesString:self];
}

@end
