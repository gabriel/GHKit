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

- (void)testFullDescription {
	NSError *detailedError = [NSError errorWithDomain:@"Detail" code:-2 userInfo:nil];
	
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSArray arrayWithObject:detailedError] forKey:@"NSDetailedErrors"];
	NSError *error = [NSError errorWithDomain:@"Test" code:-1 userInfo:userInfo];
	NSString *fullDescription = [error gh_fullDescription];
	GHTestLog(@"Full description: %@", fullDescription);
}

@end
