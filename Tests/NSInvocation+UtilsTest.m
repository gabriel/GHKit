//
//  NSInvocation+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSInvocation+Utils.h"

@interface NSInvocationUtilsTest : SenTestCase {
	BOOL invokeTesting1Called_;
	BOOL invokeTesting2Called_;
}

@end

@implementation NSInvocationUtilsTest

- (void)testInvoke {
	
	[NSInvocation gh_invokeWithTarget:self selector:@selector(_invokeTesting1:withObject:withObject:) 
												withObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:3], nil];
	
	STAssertTrue(invokeTesting1Called_, @"Method was not called");
}
	 
- (void)_invokeTesting1:(NSNumber *)number1 withObject:number2 withObject:number3 {
	STAssertEqualObjects([NSNumber numberWithInteger:1], number1, nil);
	STAssertEqualObjects([NSNumber numberWithInteger:2], number2, nil);
	STAssertEqualObjects([NSNumber numberWithInteger:3], number3, nil);
	invokeTesting1Called_ = YES;
}

- (void)testInvokeWithArgumentsArrayAndNSNull {
	NSArray *arguments = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNull null], [NSNumber numberWithInteger:3], nil];
	[NSInvocation gh_invokeWithTarget:self selector:@selector(_invokeTesting2:withObject:withObject:) arguments:arguments];
	
	STAssertTrue(invokeTesting2Called_, @"Method was not called");
}

- (void)_invokeTesting2:(NSNumber *)number1 withObject:nilValue withObject:number3 {
	STAssertEqualObjects([NSNumber numberWithInteger:1], number1, nil);
	STAssertNULL(nilValue, @"Should be nil");
	STAssertEqualObjects([NSNumber numberWithInteger:3], number3, nil);
	invokeTesting2Called_ = YES;
}

@end
