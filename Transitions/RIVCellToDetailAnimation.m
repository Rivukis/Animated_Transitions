//
//  RIVCellToDetailAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVCellToDetailAnimation.h"

static const NSTimeInterval defaultDuration = 0.4;

@implementation RIVCellToDetailAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting && self.customDurationPresent) return self.customDurationPresent.doubleValue;
    if (!self.isPresenting && self.customDurationDismiss) return self.customDurationDismiss.doubleValue;
    
    return defaultDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIImageView *virtualImage;
    
    if (self.isPresenting) {
        toViewController.view.alpha = 0.0f;
        virtualImage = [[UIImageView alloc] initWithFrame:self.cellImageCorrectedFrame];
    } else {
        fromViewController.view.alpha = 1.0f;
        virtualImage = [[UIImageView alloc] initWithFrame:self.detailImageCorrectedFrame];
        [containerView bringSubviewToFront:fromViewController.view];
    }
    
    // Animation Preparations
    [containerView addSubview:toViewController.view];
    virtualImage.image = self.cellImageView.image;
    
    [containerView addSubview:virtualImage];
    self.detailImageView.hidden = YES;
    self.cellImageView.hidden = YES;
    
    // Transformations
    CGFloat scaleFactorX = self.detailImageCorrectedFrame.size.width / self.cellImageCorrectedFrame.size.width;
    CGFloat scaleFactorY = self.detailImageCorrectedFrame.size.height / self.cellImageCorrectedFrame.size.width;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        if (self.isPresenting) {
            toViewController.view.alpha = 1.0f;
            virtualImage.transform = CGAffineTransformMakeScale(scaleFactorX, scaleFactorY);
            virtualImage.center = CGPointMake(self.detailImageCorrectedFrame.size.width/2 + self.detailImageCorrectedFrame.origin.x,
                                              self.detailImageCorrectedFrame.size.height/2 + self.detailImageCorrectedFrame.origin.y);
        } else {
            fromViewController.view.alpha = 0.0f;
            virtualImage.transform = CGAffineTransformMakeScale(1/scaleFactorX, 1/scaleFactorY);
            virtualImage.center = CGPointMake(self.cellImageCorrectedFrame.size.width/2 + self.cellImageCorrectedFrame.origin.x,
                                              self.cellImageCorrectedFrame.size.height/2 + self.cellImageCorrectedFrame.origin.y);
        }
    } completion:^(BOOL finished) {
        self.detailImageView.image = virtualImage.image;
        self.detailImageView.hidden = NO;
        self.cellImageView.hidden = NO;
        
        [virtualImage removeFromSuperview];
        [transitionContext completeTransition:finished];
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
