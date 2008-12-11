//
//  UINavigationController+PopDelegate.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/7/08.
//  Copyright 2008. All rights reserved.
//

#import "GHUINavigationController+PopDelegate.h"
#import "JRSwizzle.h"

@implementation UINavigationController (GHPopDelegate)

- (NSArray *)_popToRootViewControllerAnimated:(BOOL)animated {
	NSMutableArray *willPopControllers = [[self.viewControllers mutableCopy] autorelease];
	[willPopControllers removeObject:[self.viewControllers objectAtIndex:0]];
	
	if ([self.delegate respondsToSelector:@selector(navigationController:willPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationController:self willPopViewControllers:willPopControllers animated:animated];
	}
	
	// Call original	
	NSArray *poppedViewControllers = [self _popToRootViewControllerAnimated:animated];
	
	if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationController:self didPopViewControllers:poppedViewControllers animated:animated];
	}
	return poppedViewControllers;
}

- (NSArray *)_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSUInteger index = [self.viewControllers indexOfObject:viewController];
	if (index != NSNotFound && index < ([self.viewControllers count] - 1)) {	
		NSArray *willPopControllers = [self.viewControllers subarrayWithRange:NSMakeRange(index + 1, ([self.viewControllers count] - index))];
	
		if ([self.delegate respondsToSelector:@selector(navigationController:willPopViewControllers:animated:)]) {
			[((id)self.delegate) navigationController:self willPopViewControllers:willPopControllers animated:animated];
		}
	}
	
	// Call original
	NSArray *poppedViewControllers = [self _popToViewController:viewController animated:animated];
	
	if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewController:animated:)]) {
		[((id)self.delegate) navigationController:self didPopViewControllers:poppedViewControllers animated:animated];
	}
	return poppedViewControllers;
}

- (UIViewController *)_popViewControllerAnimated:(BOOL)animated {
	
	UIViewController *willPopController = self.topViewController;
	if ([self.delegate respondsToSelector:@selector(navigationController:willPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationController:self willPopViewControllers:[NSArray arrayWithObject:willPopController] animated:animated];
	}
	
	// Call original	
	UIViewController *viewController = [self _popViewControllerAnimated:animated];
	NSAssert(willPopController == viewController, @"What we popped wasn't what was sent to willPop delegate");
	
	if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationController:self didPopViewControllers:[NSArray arrayWithObject:viewController] animated:animated];
	}
	return viewController;
}

+ (void)addPopDelegate:(NSError **)error {
	[UINavigationController jr_swizzleMethod:@selector(popToRootViewControllerAnimated:) withMethod:@selector(_popToRootViewControllerAnimated:) error:error];
	[UINavigationController jr_swizzleMethod:@selector(popToViewController:animated:) withMethod:@selector(_popToViewController:animated:) error:error];
	[UINavigationController jr_swizzleMethod:@selector(popViewControllerAnimated:) withMethod:@selector(_popViewControllerAnimated:) error:error];	
}

@end
