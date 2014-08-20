//
//  RIVCellToDetailAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVCellToDetailAnimation.h"

static const NSTimeInterval defaultDuration = 0.4;

@interface RIVCellToDetailAnimation ()

@property (strong, nonatomic) NSMutableArray *fromImageViews;
@property (strong, nonatomic) NSMutableArray *toImageViews;

@end

@implementation RIVCellToDetailAnimation

@synthesize isPresenting = _isPresenting;

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
    CGRect cellImageReferenceFrame;
    CGRect detailImageReferenceFrame;
    
    [containerView addSubview:toViewController.view];
    
    // Animation Preparations
    if (self.isPresenting) {
        cellImageReferenceFrame = [fromViewController.view convertRect:self.cellImageView.frame fromView:self.cellImageView.superview];
        detailImageReferenceFrame = [toViewController.view convertRect:self.detailImageView.frame fromView:self.detailImageView.superview];
        
        toViewController.view.alpha = 0.0f;
        virtualImage = [[UIImageView alloc] initWithFrame:cellImageReferenceFrame];
    } else {
        cellImageReferenceFrame = [toViewController.view convertRect:self.cellImageView.frame fromView:self.cellImageView.superview];
        detailImageReferenceFrame = [fromViewController.view convertRect:self.detailImageView.frame fromView:self.detailImageView.superview];
        
        fromViewController.view.alpha = 1.0f;
        virtualImage = [[UIImageView alloc] initWithFrame:detailImageReferenceFrame];
        [containerView bringSubviewToFront:fromViewController.view];
    }
    
    virtualImage.image = self.cellImageView.image;
    [containerView addSubview:virtualImage];
    self.detailImageView.hidden = YES;
    self.cellImageView.hidden = YES;
    
    // Transformations
    CGFloat scaleFactorX = detailImageReferenceFrame.size.width / cellImageReferenceFrame.size.width;
    CGFloat scaleFactorY = detailImageReferenceFrame.size.height / cellImageReferenceFrame.size.width;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        if (self.isPresenting) {
            toViewController.view.alpha = 1.0f;
            virtualImage.transform = CGAffineTransformMakeScale(scaleFactorX, scaleFactorY);
            virtualImage.center = CGPointMake(detailImageReferenceFrame.size.width/2 + detailImageReferenceFrame.origin.x,
                                              detailImageReferenceFrame.size.height/2 + detailImageReferenceFrame.origin.y);
        } else {
            fromViewController.view.alpha = 0.0f;
            virtualImage.transform = CGAffineTransformMakeScale(1/scaleFactorX, 1/scaleFactorY);
            virtualImage.center = CGPointMake(cellImageReferenceFrame.size.width/2 + cellImageReferenceFrame.origin.x,
                                              cellImageReferenceFrame.size.height/2 + cellImageReferenceFrame.origin.y);
        }
    } completion:^(BOOL finished) {
        self.detailImageView.image = virtualImage.image;
        self.detailImageView.hidden = NO;
        self.cellImageView.hidden = NO;
        
        [virtualImage removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)setupObjectArrays
{
    if (self.fromObjects.count != self.toObjects.count) {
        [NSException raise:NSInternalInconsistencyException format:@"Object array counts are not equal"];
    }
    
    NSInteger currentIndex;
    for (id item in self.fromObjects) {
        currentIndex = [self.fromObjects indexOfObject:item];
        if (![self.fromObjects[currentIndex] isKindOfClass:[self.toObjects[currentIndex] class]]) {
            [NSException raise:NSInternalInconsistencyException
                        format:@"The class of objects in toObjects and fromObjects at corresponding indexes do not match."];
        }
        
        if ([self.fromObjects[currentIndex] isKindOfClass:UIImageView.class]) {
            [self.fromImageViews addObject:self.fromObjects[currentIndex]];
            [self.toImageViews addObject:self.toObjects[currentIndex]];
        } else {
            [NSException raise:NSInternalInconsistencyException format:@"Unsupported object class passed to animation"];
        }
    }
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
