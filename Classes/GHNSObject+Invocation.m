//
//  GHNSObject+Invocation.m
//  GHKit
//
//  Created by Gabriel Handford on 1/18/09.
//  Copyright 2009. All rights reserved.
//

#import "GHNSObject+Invocation.h"


@implementation NSObject (GHInvocation)

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
	if (!onMainThread) {
		[NSInvocation gh_invokeWithTarget:self selector:selector arguments:arguments];	
	} else {
		[NSInvocation gh_invokeTargetOnMainThread:self selector:selector waitUntilDone:waitUntilDone arguments:arguments];	
	}
}

@end
