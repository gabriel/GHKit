//
//  GHNSObject+Invocation.m
//  GHKit
//
//  Created by Gabriel Handford on 1/18/09.
//  Copyright 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "GHNSObject+Invocation.h"
#import "GHKitDefines.h"

@implementation NSObject (GHInvocation_GHKIT)

- (id)gh_performIfRespondsToSelector:(SEL)selector {
	if ([self respondsToSelector:selector]) return [self performSelector:selector];
	return nil;
}

- (id)gh_performIfRespondsToSelector:(SEL)selector withObjects:object, ... {
	if ([self respondsToSelector:selector]) {
		GHConvertVarArgs(object);
		return [NSInvocation gh_invokeWithTarget:self selector:selector arguments:arguments];
	}
	return nil;
}

- (id)gh_performSelector:(SEL)selector withObjects:object, ... {
	GHConvertVarArgs(object);
	return [NSInvocation gh_invokeWithTarget:self selector:selector arguments:arguments];	
}

- (id)gh_performSelector:(SEL)selector afterDelay:(NSTimeInterval)delay withObjects:object, ... {
	GHConvertVarArgs(object);
	return [NSInvocation gh_invokeWithTarget:self selector:selector afterDelay:delay arguments:arguments];		
}

- (void)gh_performSelectorOnMainThread:(SEL)selector withObjects:object, ... {
	GHConvertVarArgs(object);
	[NSInvocation gh_invokeTargetOnMainThread:self selector:selector waitUntilDone:NO arguments:arguments];	
}

- (void)gh_performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)waitUntilDone withObjects:object, ... {
	GHConvertVarArgs(object);
	[NSInvocation gh_invokeTargetOnMainThread:self selector:selector waitUntilDone:waitUntilDone arguments:arguments];	
}

- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone withObjects:object, ... {
	GHConvertVarArgs(object);
	[self gh_performSelector:selector onMainThread:onMainThread waitUntilDone:waitUntilDone arguments:arguments];
}	

- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone arguments:(NSArray *)arguments {
	[self gh_performSelector:selector onMainThread:onMainThread waitUntilDone:waitUntilDone afterDelay:-1 arguments:arguments];
}

- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone 
								afterDelay:(NSTimeInterval)delay arguments:(NSArray *)arguments {

	if (!onMainThread) {
		[NSInvocation gh_invokeWithTarget:self selector:selector afterDelay:delay arguments:arguments];	
	} else {
		[NSInvocation gh_invokeTargetOnMainThread:self selector:selector waitUntilDone:waitUntilDone afterDelay:delay arguments:arguments];	
	}
}

// From DDFoundation, NSObject+DDExtensions 
// (Changed namespaced to make it easier to include in static library without conflicting)

/*!
 TODO(gabe): Possible to detect if we are nesting proxy calls?
 */
- (GHNSInvocationProxy *)_initProxy {	
	GHNSInvocationProxy *proxy = [GHNSInvocationProxy invocation];
	proxy.target = self;
	return proxy;
}

- (id)gh_proxyOnMainThread {
	return [self gh_proxyOnMainThread:NO];
}

- (id)gh_proxyOnMainThread:(BOOL)waitUntilDone {
	GHNSInvocationProxy *proxy = [self _initProxy];
	proxy.thread = [NSThread mainThread];
	proxy.waitUntilDone = waitUntilDone;
	return proxy;
}

- (id)gh_proxyOnThread:(NSThread *)thread {
	return [self gh_proxyOnThread:thread waitUntilDone:NO];
}

- (id)gh_proxyDetachThreadWithCallback:(id)target action:(SEL)action context:(id)context {
	GHNSInvocationProxy *proxy = [self _initProxy];
	GHNSInvocationProxyCallback *callback = [[GHNSInvocationProxyCallback alloc] initWithTarget:target action:action context:context];
	proxy.detachCallback = callback;
	[callback release];
	return proxy;
}

- (id)gh_proxyOnThread:(NSThread *)thread waitUntilDone:(BOOL)waitUntilDone {
	GHNSInvocationProxy *proxy = [self _initProxy];
	proxy.thread = thread;
	proxy.waitUntilDone = waitUntilDone;
	return proxy;
}

- (id)gh_proxyAfterDelay:(NSTimeInterval)delay {
	GHNSInvocationProxy *proxy = [self _initProxy];			
	proxy.delay = delay;
	return proxy;
}

- (id)gh_argumentProxy:(SEL)selector {
	GHNSInvocationProxy *proxy = [self _initProxy];
	proxy.selector = selector;
	return proxy;
}

- (id)gh_argumentProxy:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone {
	GHNSInvocationProxy *proxy = [self _initProxy];
	proxy.selector = selector;
	proxy.thread = [NSThread mainThread];
	proxy.waitUntilDone = waitUntilDone;
	return proxy;
}

- (id)gh_logProxy {
	NSLog(@"Tracing: %@", self);
	GHNSInvocationProxy *proxy = [self _initProxy];
	proxy.tracer = [GHNSLogInvocationTracer shared];
	return [proxy prepareWithInvocationTarget:self];
}

@end
