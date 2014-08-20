//
//  RIVScaleAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVScaleAnimation.h"

static const NSTimeInterval defaultDuration = 0.5;

@interface RIVScaleAnimation ()

@property (assign, nonatomic) BOOL centerAssigned;

@end

@implementation RIVScaleAnimation

@synthesize isPresenting = _isPresenting;

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
    CGAffineTransform transform = CGAffineTransformMakeScale(ACTING_ZERO, ACTING_ZERO);
    CGPoint trueCenter = CGPointMake(containerView.frame.size.width/2, containerView.frame.size.height/2);
    if (!self.centerAssigned) self.customCenterPoint = trueCenter;
    
    [containerView addSubview:toController.view];
    
    if (self.isPresenting) {
        presentedView = toController.view;
        presentedView.transform = transform;
        transform = CGAffineTransformIdentity;
        presentedView.center = self.customCenterPoint;
    } else {
        presentedView = fromController.view;
        [containerView bringSubviewToFront:presentedView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        presentedView.transform = transform;
        if (self.isPresenting) {presentedView.center = trueCenter;}
        else {presentedView.center = self.customCenterPoint;}
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
- (void)setCustomCenterPoint:(CGPoint)customCenterPoint
{
    self.centerAssigned = YES;
    _customCenterPoint = customCenterPoint;
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
