//
//  RIVTransitionController.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVTransitionController.h"
#import "RIVBaseAnimation.h"

@implementation RIVTransitionController

- (instancetype)initWithAnimation:(RIVBaseAnimation *)animation
{
    self = [super init];
    if (self) {
        self.animation = animation;
    }
    return self;
}


#pragma mark - Animated Transitioning Methods


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animation.isPresenting = YES;
    return self.animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animation.isPresenting = NO;
    return self.animation;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:   self.animation.isPresenting = YES;      break;
        case UINavigationControllerOperationPop:    self.animation.isPresenting = NO;       break;
        default:                                    return nil;
    }
    
    return self.animation;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSInteger fromVCindex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toVCindex = [tabBarController.viewControllers indexOfObject:toVC];
    
    if (toVCindex > fromVCindex) {
        self.animation.isPresenting = YES;
    } else {
        self.animation. isPresenting = NO;
    }
    
    return self.animation;
}


#pragma mark - Interactive Transitioning Methods


//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
//{
//    
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
//{
//    
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    
//}


#pragma mark - UINavigationControllerDelegate Methods (passed on)


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [self.navDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [self.navDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
//}


@end
