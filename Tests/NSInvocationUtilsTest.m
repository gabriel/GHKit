//
//  NSInvocation+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSInvocation+Utils.h"
#import "GHNSObject+Invocation.h"
#import "GHNSInvocationProxy.h"

@interface NSInvocationUtilsTest : GHTestCase {
	BOOL invokeTesting1Called_;
	BOOL invokeTesting2Called_;
	BOOL invokeTesting3Called_;
	BOOL invokeTesting4Called_;
	BOOL invokeTestingMainThreadCalled_;
	BOOL invokeTestingNestedCalled_;
	BOOL invokeTestProxyDelegateCalled_;
	BOOL invokeTestArgumentProxyCalled_;
	BOOL invokeDetachCalled_;
}

@end

@interface TestWithDelegate : NSObject { 
	id delegate_;
}
@property (assign, nonatomic) id delegate;
- (void)runInvokeTestProxyDelegate;
@end

@interface NSInvocationUtilsTest ()
- (void)_invokeTesting4:(NSInteger)n;
- (void)_invokeTestingNested:(NSInteger)n;
- (void)_invokeTestingMainThread:(NSInteger)n;
- (void)_invokeDetach:(NSInteger)n;
@end

@protocol TestArgumentProxy 
- (void)s:(NSString *)s n:(NSInteger)n b:(BOOL)b;
@end

@implementation NSInvocationUtilsTest

- (void)setUpClass {
  invokeTesting1Called_ = NO;
  invokeTesting2Called_ = NO;
  invokeTesting3Called_ = NO;
  invokeTesting4Called_ = NO;
  invokeTestingMainThreadCalled_ = NO;
  invokeTestingNestedCalled_ = NO;
  invokeTestProxyDelegateCalled_ = NO;
  invokeTestArgumentProxyCalled_ = NO;
  invokeDetachCalled_ = NO;
}

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

- (void)testInvokeOnMainThread {
	[[self gh_proxyOnMainThread:YES] _invokeTestingMainThread:1];
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	GHAssertTrue(invokeTestingMainThreadCalled_, @"Method was not called");
}

- (void)_invokeTestingMainThread:(NSInteger)n {
	GHAssertTrue([NSThread isMainThread], nil);
	GHAssertTrue(n == 1, @"Should be equal to 1 but was %d", n);
	invokeTestingMainThreadCalled_ = YES;
}

// TODO(gabe): This isn't a real failure
- (void)_testInvokeNestedProxy {
	[[[self gh_proxyOnMainThread:YES] gh_proxyAfterDelay:0.1] _invokeTestingNested:1];
	
	GHAssertFalse(invokeTestingNestedCalled_, @"Method should be delayed");
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	GHAssertTrue(invokeTestingNestedCalled_, @"Method was not called");
}

- (void)_invokeTestingNested:(NSInteger)n {
  GHTestLog(@"invokeTestingNestedCalled on main thread: %d", [NSThread isMainThread]);
	GHAssertTrue([NSThread isMainThread], @"Should be on main thread; This is currently an expected failure!");
	GHAssertTrue(n == 1, @"Should be equal to 1 but was %d", n);
	invokeTestingNestedCalled_ = YES;
}

- (void)testProxyDelegate {
	TestWithDelegate *test = [[TestWithDelegate alloc] init];
	GHTestLog(@"Setting delegate");
	test.delegate = [self gh_proxyOnMainThread];
	
	GHTestLog(@"Creating thread");
	NSThread* thread = [[NSThread alloc] initWithTarget:self												
																						 selector:@selector(_threadMain:)
																								 object:test];
	
	GHTestLog(@"Starting thread");
	[thread start];
	// Wait for thread to call
	[NSThread sleepForTimeInterval:0.3];
	GHAssertTrue(invokeTestProxyDelegateCalled_, nil);
  [thread autorelease];
  [test autorelease];
}

- (void)_threadMain:(id)test {
	[test runInvokeTestProxyDelegate];
}

- (void)_invokeTestProxyDelegate {
	GHTestLog(@"Invoked on main thread? %d", [NSThread isMainThread]);
	GHAssertTrue([NSThread isMainThread], @"Delegate should have called back on main thread");
	invokeTestProxyDelegateCalled_ = YES;
}

- (void)testArgumentProxy {
	SEL selector = @selector(_invokeTestArgumentProxy:n:b:);
	[[self gh_argumentProxy:selector] s:@"test" n:20 b:NO];
	GHAssertTrue(invokeTestArgumentProxyCalled_, nil);
}

- (void)_invokeTestArgumentProxy:(NSString *)s n:(NSInteger)n b:(BOOL)b {
	GHAssertEqualStrings(@"test", s, nil);
	GHAssertTrue(20 == n, nil);
	GHAssertFalse(b, nil);
	invokeTestArgumentProxyCalled_ = YES;
}

- (void)testDetach {
	GHTestLog(@"Calling on thread: %@", [NSThread currentThread]);
	[[self gh_proxyDetachThreadWithCallback:self action:@selector(_detachCallback:) context:nil] _invokeDetach:1];
	// Wait for thread to call back
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	[NSThread sleepForTimeInterval:0.1];
	GHAssertTrue(invokeDetachCalled_, nil);
}

- (void)_invokeDetach:(NSInteger)n {
	GHTestLog(@"Detached thread: %@", [NSThread currentThread]);
	[NSNumber numberWithInteger:n]; // Create object to make sure we have autorelease pool
	GHAssertTrue(1 == n, nil);
	invokeDetachCalled_ = YES;
}

// TODO(gabe): Fix test so this does something, but seems to work
- (void)_detachCallback:(id)context {  }

@end

@implementation TestWithDelegate

@synthesize delegate=delegate_;

- (void)runInvokeTestProxyDelegate {	
	[delegate_ _invokeTestProxyDelegate];
}

@end
