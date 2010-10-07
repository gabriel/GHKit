//
//  GHNSInvocation+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 1/17/09.
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

/*!
 Invocation helper.
 */
@interface NSInvocation(GHUtils_GHKIT)

/*!
 Invoke on main thread.
 @param waitUntilDone Whether to join on the call
 */
- (void)gh_invokeOnMainThread:(BOOL)waitUntilDone;

/*!
 Invoke target selector with multiple arguments.
 @param target Invocation target
 @param selector Method
 @param withObjects (Variable) Arguments list
 */
+ (id)gh_invokeWithTarget:(id)target selector:(SEL)selector withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke target selector with multiple arguments.
 @param target Invocation target
 @param selector Method
 @param arguments Arguments list
 */
+ (id)gh_invokeWithTarget:(id)target selector:(SEL)selector arguments:(NSArray *)arguments;

/*!
 Invoke target selector with multiple arguments.
 @param target Invocation target
 @param selector Method
 @param afterDelay Time interval for delay (in seconds)
 @param arguments Arguments list
 */
+ (id)gh_invokeWithTarget:(id)target selector:(SEL)selector afterDelay:(NSTimeInterval)delay arguments:(NSArray *)arguments;

/*!
 Invoke target selector on main thread with multiple arguments.
 Use [NSNull null] for nil arguments.
 @param target Target
 @param selector Action
 @param waitUntilDone Whether to wait for call to finish
 @param withObjects Nil terminated list of (object) arguments; Use [NSNull null] for nil arguments
 */
+ (void)gh_invokeTargetOnMainThread:(id)target selector:(SEL)selector waitUntilDone:(BOOL)waitUntilDone withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Invoke target selector on main thread with multiple arguments.
 @param target Target
 @param selector Action
 @param waitUntilDone Whether to wait for call to finish
 @param arguments Arguments list
 */
+ (void)gh_invokeTargetOnMainThread:(id)target selector:(SEL)selector waitUntilDone:(BOOL)waitUntilDone arguments:(NSArray *)arguments;

/*!
Invoke target selector on main thread with multiple arguments.
 @param target Target
 @param selector Action
 @param waitUntilDone Whether to wait for call to finish
 @param afterDelay Time interval for delay (in seconds)
 @param arguments Arguments list
 */
+ (void)gh_invokeTargetOnMainThread:(id)target selector:(SEL)selector waitUntilDone:(BOOL)waitUntilDone afterDelay:(NSTimeInterval)delay arguments:(NSArray *)arguments;

/*!
 Create invocation with variable arguments.
 Use [NSNull null] for nil arguments.
 @param target Invocation target
 @param selector Method
 @param hasReturnValue Will be set to YES, if there is a return value
 @param withObjects (Variable) Arguments list
 */
+ (NSInvocation *)gh_invocationWithTarget:(id)target selector:(SEL)selector hasReturnValue:(BOOL *)hasReturnValue withObjects:object, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Create invocation with variable arguments.
 Use [NSNull null] for nil arguments.
 @param target Invocation target
 @param selector Method
 @param hasReturnValue Will be set to YES, if there is a return value
 @param arguments Arguments array
 */
+ (NSInvocation *)gh_invocationWithTarget:target selector:(SEL)selector hasReturnValue:(BOOL *)hasReturnValue arguments:(NSArray *)arguments;

@end
