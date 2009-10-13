//
//  GHNSInvocationProxy.m
//  GHKit
//
//  Modified by Gabriel Handford on 5/9/09.
//  This class is based on DDInvocationGrabber.
//

/*
 * Copyright (c) 2007-2009 Dave Dribin
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


/*
 *  This class is based on CInvocationGrabber:
 *
 *  Copyright (c) 2007, Toxic Software
 *  All rights reserved.
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  * Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *  
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  
 *  * Neither the name of the Toxic Software nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE
 *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *  THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "GHNSInvocationProxy.h"

@implementation GHNSInvocationProxy

@synthesize target=target_, invocation=invocation_, waitUntilDone=waitUntilDone_, thread=thread_, 
delay=delay_, selector=selector_, tracer=tracer_, detachCallback=detachCallback_;

+ (id)invocation {
	return [[[self alloc] init] autorelease];
}

- (id)init {
	delay_ = -1;
	return self;
}

- (id)prepareWithInvocationTarget:(id)target {
	self.target = target;
	return self;
}

- (id)prepareWithInvocationTarget:(id)target selector:(SEL)selector {
	self.target = target;
	self.selector = selector;
	return self;
}

- (void)dealloc {
	[target_ release];
	[invocation_ release];
	[thread_ release];
	[detachCallback_ release];
	[super dealloc];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	// For argument proxy, if we are overriding the invoking selector
	if (selector_ != NULL) selector = selector_;
	
	return [[self target] methodSignatureForSelector:selector];
}

- (NSString *)invocationDescription:(NSInvocation *)invocation {
	return [NSString stringWithFormat:@"target=%@, selector=%@, signature=%@", invocation.target, NSStringFromSelector(invocation.selector), [invocation methodSignature]];
}

- (void)forwardInvocation:(NSInvocation *)invocation {	
	self.invocation = invocation;
	
	invocation.target = target_;
	// For argument proxy, if we are overriding the invoking selector
	if (selector_ != NULL) invocation.selector = selector_;
	
	[invocation retainArguments];
	
	// Check for unsupported combinations
	if (thread_ && delay_ >= 0)
		[NSException raise:NSInvalidArgumentException format:@"Running on thread with delay is not supported at the same time"];
	if (thread_ && detachCallback_)
		[NSException raise:NSInvalidArgumentException format:@"Running on thread with detached callback is not supported at the same time"];
	if (detachCallback_ && delay_ >= 0)
		[NSException raise:NSInvalidArgumentException format:@"Running with delay and detached callback is not supported at the same time"];
	
	[tracer_ proxy:self willInvoke:invocation];
	if (thread_) {
		[invocation_ performSelector:@selector(invoke) onThread:thread_ withObject:nil waitUntilDone:waitUntilDone_];
	} else if (detachCallback_) {		
		[NSThread detachNewThreadSelector:@selector(invoke:) toTarget:detachCallback_ withObject:invocation_];
	} else {
		if (delay_ >= 0) {
			[invocation_ performSelector:@selector(invoke) withObject:nil afterDelay:delay_];
		} else {
			[invocation_ performSelector:@selector(invoke) withObject:nil];
		}
	}
	
	[tracer_ proxy:self didInvoke:invocation];
}



@end


@implementation GHNSInvocationProxyCallback 

- (id)initWithTarget:(id)target action:(SEL)action context:(id)context {
	if ((self = [super init])) {
		target_ = [target retain];
		action_ = action;
		context_ = [context retain];
		thread_ = [[NSThread currentThread] retain];
	}
	return self;
}

- (void)invoke:(NSInvocation *)invocation {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[invocation invoke];
	[self performSelector:@selector(_callback) onThread:thread_ withObject:nil waitUntilDone:YES];
	[pool release];
}

- (void)_callback {
	[target_ performSelector:action_ withObject:context_];
	[target_ release];
	[thread_ release];
	[context_ release];
}

@end


@implementation GHNSLogInvocationTracer

static GHNSLogInvocationTracer *gGHNSLogInvocationTracer = NULL;

+ (GHNSLogInvocationTracer *)shared {
	@synchronized([GHNSLogInvocationTracer class]) {
		if (gGHNSLogInvocationTracer == NULL) {
			gGHNSLogInvocationTracer = [[GHNSLogInvocationTracer alloc] init];
		}
	}
	return gGHNSLogInvocationTracer;
}


- (void)proxy:(GHNSInvocationProxy *)proxy willInvoke:(NSInvocation *)invocation {
	NSLog(@"[TRACE] [%@ %@]", NSStringFromClass([invocation.target class]), NSStringFromSelector(invocation.selector));
	_interval = [NSDate timeIntervalSinceReferenceDate];
}

- (void)proxy:(GHNSInvocationProxy *)proxy didInvoke:(NSInvocation *)invocation {
	_interval -= -[NSDate timeIntervalSinceReferenceDate];
	NSUInteger length = [[invocation methodSignature] methodReturnLength];
	if (length == 0) NSLog(@"[TRACE] (%0.4fs)", _interval);
	else {
		const char *returnType = [[invocation methodSignature] methodReturnType];
		NSString *returnTypeString = [[[NSString alloc] initWithCString:returnType encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"[TRACE] %@ (%0.4fs)", returnTypeString, _interval);
	}	
}

@end
