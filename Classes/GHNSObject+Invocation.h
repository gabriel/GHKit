//
//  GHNSObject+Invocation.h
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

#import "GHNSInvocation+Utils.h"
#import "GHNSInvocationProxy.h"

/*!
 Adds performSelector methods that take a nil-terminated variable argument list,
 for when you need to pass more arguments to performSelector.
 */
@interface NSObject(GHInvocation_GHKIT)

/*!
 Perform selector if responds.
 @param selector
 @result nil if we don't respond to the selector, otherwise the selector result
 */
- (id)gh_performIfRespondsToSelector:(SEL)selector;

/*!
 Perform selector if responds with multiple arguments.
 @param selector
 @param withObjects nil terminated variable argument list 
 @result nil if we don't respond to the selector, otherwise the selector result
 */
- (id)gh_performIfRespondsToSelector:(SEL)selector withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector with arguments.
 @param selector
 @param withObjects nil terminated variable argument list 
 */
- (id)gh_performSelector:(SEL)selector withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector after delay with arguments.
 @param selector
 @param delay
 @param withObjects nil terminated variable argument list 
 */
- (id)gh_performSelector:(SEL)selector afterDelay:(NSTimeInterval)delay withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector with arguments on main thread.
 Does not wait until selector is finished.
 @param selector
 @param withObjects nil terminated variable argument list 
 */
- (void)gh_performSelectorOnMainThread:(SEL)selector withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector with arguments on main thread.
 @param selector
 @param waitUntilDone Whether to join on selector and wait for it to finish.
 @param withObjects nil terminated variable argument list 
 */
- (void)gh_performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)waitUntilDone withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector with arguments.
 @param selector
 @param onMainThread Whether to perform on main thread or current thread
 @param waitUntilDone Whether to join on selector and wait for it to finish.
 @param withObjects nil terminated variable argument list 
 */
- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke selector with arguments;
 @param selector
 @param onMainThread Whether to perform on main thread or current thread
 @param waitUntilDone Whether to join on selector and wait for it to finish.
 @param arguments List of arguments
 */
- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone arguments:(NSArray *)arguments;

/*!
 Invoke selector with arguments after delay.
 @param selector
 @param onMainThread Whether to perform on main thread or current thread
 @param waitUntilDone Whether to join on selector and wait for it to finish.
 @param afterDelay Delay in seconds
 @param arguments List of arguments
 */
- (void)gh_performSelector:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone 
								afterDelay:(NSTimeInterval)delay arguments:(NSArray *)arguments;


#pragma mark Invocation proxies

/*!
 Proxy for invoking on main thread (without waiting until done).
 @result Proxy
 */
- (id)gh_proxyOnMainThread;

/*!
 Proxy for invoking on main thread.
 @param waitUntilDone Whether to block until call is finished
 @result Proxy
 */
- (id)gh_proxyOnMainThread:(BOOL)waitUntilDone;

/*!
 Proxy on thread (without blocking until done).
 @param thread Thread to invoke on
 @result Proxy
 */
- (id)gh_proxyOnThread:(NSThread *)thread;

/*!
 Proxy for invoking on thread.
 @param thread Thread to invoke on
 @param waitUntilDone Whether to block until call is finished
 @result Proxy
 */
- (id)gh_proxyOnThread:(NSThread *)thread waitUntilDone:(BOOL)waitUntilDone;

/*!
 Proxy for invoking after delay.
 
 @code 
 NSMutableArray array = [NSMutableArray array];
 // Inserts object after 2 second delay
 [[array gh_proxyAfterDelay:2.0] insertObject:@"foo" atIndex:0];
 @endcode
 
 @param delay Time (in seconds) to wait before calling.
 @result proxy
 */
- (id)gh_proxyAfterDelay:(NSTimeInterval)delay;

/*!
 Proxy for selector.
 For calling a selector with any type and number of arguments.
 
 Overriding the selector only make sense when using the "argument proxy".
 For example, 
 
 @code
 SEL selector = @selector(bar:baz:);
 [[foo gh_argumentProxy:selector] arg:10 arg:YES];
 @endcode
 
 Will call [foo bar:10 baz:YES];  (and not arg:arg: selector which doesn't exist).
 
 This allows you to call a selector variable with primitive and multi arguments, 
 whereas before you would have to use a manually constructed NSInvocation (or 
 performSelector if you had only object arguments).
 
 @param selector
 @result proxy
 */
- (id)gh_argumentProxy:(SEL)selector;

/*!
 Proxy for selector on main thread.
 */
- (id)gh_argumentProxy:(SEL)selector onMainThread:(BOOL)onMainThread waitUntilDone:(BOOL)waitUntilDone;

/*!
 Special logging proxy; In progress.
 */
- (id)gh_logProxy;

/*!
 Proxy call on new thread.
 Calls are responsible for setting up their own NSAutoreleasePool's.
 @param target Callback target
 @param action Callback action
 @param context Callback argument
 @result proxy
 */ 
- (id)gh_proxyDetachThreadWithCallback:(id)target action:(SEL)action context:(id)context;

@end
