//
//  UINavigationController+PopDelegate.h
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

#import <Foundation/Foundation.h>

// WARNING: The willPop delegates aren't fully tested!

// To enable the pop delegate, you need to setup the swizzled (aliased) methods by calling:
//   [UINavigationController addPopDelegate:nil];
//
// Adds delegate method for UINavigationControllerDelegate
//
//  - (void)navigationController:(UINavigationController *)navigationController 
//         didPopViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
//
//  - (void)navigationController:(UINavigationController *)navigationController 
//        willPopViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
//
@interface UINavigationController (GHPopDelegate)

- (NSArray *)_popToRootViewControllerAnimated:(BOOL)animated;
- (NSArray *)_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)_popViewControllerAnimated:(BOOL)animated;

+ (void)addPopDelegate:(NSError **)error;

@end

@protocol GHUINavigationControllerDelegate <NSObject>
- (void)navigationController:(UINavigationController *)navigationController 
				didPopViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;

- (void)navigationController:(UINavigationController *)navigationController 
			willPopViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
@end
