//
//  UINavigationController+PopDelegate.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/7/08.
//  Copyright 2008 Gabriel Handford
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
