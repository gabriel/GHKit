//
//  NSErrorUtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 7/7/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSError+Utils.h"

@interface NSErrorUtilsTest : GHTestCase { }
@end

@implementation NSErrorUtilsTest

- (void)testErrorFromException {
	@try {
		[NSException raise:NSGenericException format:@"my reason"];
	} @catch(NSException *e) {
		NSError *error = [NSError gh_errorFromException:e];
		GHTestLog(@"Error: %@", error);
	}
}

@end
