//
//  RIVSqueezeAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVSqueezeAnimation.h"

static const NSTimeInterval defaultDuration = 0.5;

@implementation RIVSqueezeAnimation

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
    [containerView addSubview:toController.view];
    
    CGFloat halfWidth = containerView.frame.size.width/2.0f;
    CGAffineTransform skinnyLeft = CGAffineTransformConcat(CGAffineTransformMakeScale(0.01, 1),
                                                           CGAffineTransformMakeTranslation(-halfWidth, 0.01));
    CGAffineTransform skinnyRight = CGAffineTransformConcat(CGAffineTransformMakeScale(0.01, 1),
                                                            CGAffineTransformMakeTranslation(halfWidth, 0.01));
    CGAffineTransform fromTransform;
    
    if (self.isPresenting) {
        toView.transform = skinnyRight;
        fromTransform = skinnyLeft;
    } else {
        toView.transform = skinnyLeft;
        fromTransform = skinnyRight;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = fromTransform;
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
