//
//  NSInvocation+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
//  Copyright 2009. All rights reserved.
//

#import "NSInvocation+UtilsTest.h"

#import "GHNSInvocation+Utils.h"

@implementation NSInvocationUtilsTest

- (void)testInvoke {
	
	[NSInvocation gh_invokeWithTarget:self selector:@selector(_invokeTesting1:withObject:withObject:) 
												withObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:3], nil];
	
	GHAssertTrue(invokeTesting1Called_, @"Method was not called");
}
	 
- (void)_invokeTesting1:(NSNumber *)number1 withObject:number2 withObject:number3 {
	GHAssertEqualObjects([NSNumber numberWithInteger:1], number1, nil);
	GHAssertEqualObjects([NSNumber numberWithInteger:2], number2, nil);
	GHAssertEqualObjects([NSNumber numberWithInteger:3], number3, nil);
	invokeTesting1Called_ = YES;
}

- (void)testInvokeWithArgumentsArrayAndNSNull {
	NSArray *arguments = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNull null], [NSNumber numberWithInteger:3], nil];
	[NSInvocation gh_invokeWithTarget:self selector:@selector(_invokeTesting2:withObject:withObject:) arguments:arguments];
	
	GHAssertTrue(invokeTesting2Called_, @"Method was not called");
}

- (void)_invokeTesting2:(NSNumber *)number1 withObject:nilValue withObject:number3 {
	GHAssertEqualObjects([NSNumber numberWithInteger:1], number1, nil);
	GHAssertNULL(nilValue, @"Should be nil");
	GHAssertEqualObjects([NSNumber numberWithInteger:3], number3, nil);
	invokeTesting2Called_ = YES;
}

@end
