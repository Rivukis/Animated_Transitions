//
//  RIVScaleAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVScaleAnimation.h"

static const NSTimeInterval defaultDuration = 0.5;

@implementation RIVScaleAnimation

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
    UIView *presentedView;
    CGAffineTransform transform = CGAffineTransformMakeScale(0, 0);
    
    [containerView addSubview:toController.view];
    
    if (self.isPresenting) {
        presentedView = toController.view;
        presentedView.transform = transform;
        transform = CGAffineTransformIdentity;
    } else {
        presentedView = fromController.view;
        [containerView bringSubviewToFront:presentedView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        presentedView.transform = transform;
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
