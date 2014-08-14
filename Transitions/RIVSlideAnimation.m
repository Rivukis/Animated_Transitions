//
//  RIVSlideAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVSlideAnimation.h"

static const NSTimeInterval defaultDuration = 0.4;

@implementation RIVSlideAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting && self.customDurationPresent) return self.customDurationPresent.doubleValue;
    if (!self.isPresenting && self.customDurationDismiss) return self.customDurationDismiss.doubleValue;
    
    return defaultDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = fromController.view;
    UIView *toView = toController.view;
    CGRect startingToFrame = toView.frame;
    CGRect newFromFrame = fromView.frame;
    
    [containerView addSubview:toView];
    
    if (self.isPresenting) {
        startingToFrame.origin.x = containerView.frame.size.width;
        newFromFrame.origin.x = -containerView.frame.size.width;
    } else {
        startingToFrame.origin.x = -containerView.frame.size.width;
        newFromFrame.origin.x = containerView.frame.size.width;
    }
    
    toView.frame = startingToFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        fromView.frame = newFromFrame;
        toView.frame = containerView.frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)setCustomDurationAll:(NSNumber *)durationAll
{
    self.customDurationPresent = durationAll;
    self.customDurationDismiss = durationAll;
    _customDurationAll = durationAll;
}

- (NSNumber *)defaultDuration
{
    return @(defaultDuration);
}

@end
