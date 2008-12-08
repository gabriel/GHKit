//
//  UINavigationController+PopDelegate.h
//  GHKitIPhone
//
//  Created by Gabriel Handford on 12/7/08.
//  Copyright 2008. All rights reserved.
//

#import <Foundation/Foundation.h>

// Adds delegate method for UINavigationControllerDelegate
//
//  - (void)navigationController:(UINavigationController *)navigationController 
//          willPopViewController:(UIViewController *)viewController animated:(BOOL)animated;
//
//  - (void)navigationControllerWillPopViewControllers:(UINavigationController *)navigationController 
//                                            animated:(BOOL)animated;
//
@interface UINavigationController (GHPopDelegate)

- (NSArray *)_popToRootViewControllerAnimated:(BOOL)animated;
- (NSArray *)_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)_popViewControllerAnimated:(BOOL)animated;

+ (void)addPopDelegate:(NSError **)error;

@end

@protocol GHUINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController 
				didPopViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)navigationControllerWillPopViewControllers:(UINavigationController *)navigationController 
																					animated:(BOOL)animated;
@end
