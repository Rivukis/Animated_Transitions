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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if (!self.animation) return nil;
    
    self.animation.isPresenting = YES;
    return self.animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if (!self.animation) return nil;
    
    self.animation.isPresenting = NO;
    return self.animation;
}

@end
