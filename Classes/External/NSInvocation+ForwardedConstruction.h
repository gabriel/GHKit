//
//  NSInvocation(ForwardedConstruction).h
//
//  Created by Matt Gallagher on 19/03/07.
//  Copyright 2007 Matt Gallagher. All rights reserved.
//

@interface NSInvocation (ForwardedConstruction)

+ (id)invocationWithTarget:(id)target
	invocationOut:(NSInvocation **)invocationOut;
+ (id)retainedInvocationWithTarget:(id)target
	invocationOut:(NSInvocation **)invocationOut;

@end
