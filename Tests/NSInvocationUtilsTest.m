//
//  NSInvocation+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSInvocation+Utils.h"
#import "GHNSObject+Invocation.h"

@interface NSInvocationUtilsTest : GHTestCase {
	BOOL invokeTesting1Called_;
	BOOL invokeTesting2Called_;
	BOOL invokeTesting3Called_;
	BOOL invokeTesting4Called_;
}

@end

@interface NSInvocationUtilsTest (Private)
- (void)_invokeTesting4:(NSInteger)n;
@end

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

- (void)testInvokeWithDelay {
	
	[NSInvocation gh_invokeWithTarget:self 
													 selector:@selector(_invokeTesting3:) 
												 afterDelay:0.1
													arguments:[NSArray arrayWithObjects:[NSNumber numberWithInteger:1], nil]];
	
	GHAssertFalse(invokeTesting3Called_, @"Method should be delayed");
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	GHAssertTrue(invokeTesting3Called_, @"Method was not called");
}

- (void)_invokeTesting3:(NSNumber *)number1 {
	GHAssertEqualObjects([NSNumber numberWithInteger:1], number1, nil);
	invokeTesting3Called_ = YES;
}


- (void)testInvokeProxy {
	[[self gh_proxyAfterDelay:0.1] _invokeTesting4:1];
	
	GHAssertFalse(invokeTesting4Called_, @"Method should be delayed");
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	GHAssertTrue(invokeTesting4Called_, @"Method was not called");
}

- (void)_invokeTesting4:(NSInteger)n {
	GHAssertTrue(n == 1, @"Should be equal to 1 but was %d", n);
	invokeTesting4Called_ = YES;
}

@end
