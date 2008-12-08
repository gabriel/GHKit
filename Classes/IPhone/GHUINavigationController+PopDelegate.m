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
	if ([self.delegate respondsToSelector:@selector(navigationControllerWillPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationControllerWillPopViewControllers:self animated:animated];
	}
	
	// Call original	
	NSArray *poppedViewControllers = [self _popToRootViewControllerAnimated:animated];
	
	for (UIViewController *viewController in poppedViewControllers) {
		if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewController:animated:)]) {
			[((id)self.delegate) navigationController:self didPopViewController:viewController animated:animated];
		}
	}
	return poppedViewControllers;
}

- (NSArray *)_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
	if ([self.delegate respondsToSelector:@selector(navigationControllerWillPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationControllerWillPopViewControllers:self animated:animated];
	}
	
	// Call original
	NSArray *poppedViewControllers = [self _popToViewController:viewController animated:animated];
	
	for (UIViewController *viewController in poppedViewControllers) {
		if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewController:animated:)]) {
			[((id)self.delegate) navigationController:self didPopViewController:viewController animated:animated];
		}
	}
	return poppedViewControllers;
}

- (UIViewController *)_popViewControllerAnimated:(BOOL)animated {
	if ([self.delegate respondsToSelector:@selector(navigationControllerWillPopViewControllers:animated:)]) {
		[((id)self.delegate) navigationControllerWillPopViewControllers:self animated:animated];
	}
	
	// Call original	
	UIViewController *viewController = [self _popViewControllerAnimated:animated];
	
	if ([self.delegate respondsToSelector:@selector(navigationController:didPopViewController:animated:)]) {
		[((id)self.delegate) navigationController:self didPopViewController:viewController animated:animated];
	}
	return viewController;
}

+ (void)addPopDelegate:(NSError **)error {
	[UINavigationController jr_swizzleMethod:@selector(popToRootViewControllerAnimated:) withMethod:@selector(_popToRootViewControllerAnimated:) error:error];
	[UINavigationController jr_swizzleMethod:@selector(popToViewController:animated:) withMethod:@selector(_popToViewController:animated:) error:error];
	[UINavigationController jr_swizzleMethod:@selector(popViewControllerAnimated:) withMethod:@selector(_popViewControllerAnimated:) error:error];	
}

@end
