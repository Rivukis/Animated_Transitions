//
//  RIVBaseAnimation.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVBaseAnimation.h"

@implementation RIVBaseAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(NO, @"transitionDuration: has been accessed by RIVBaseAnimation Class, should be handled by subclass of RIVBaseAnimation");
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(NO, @"animateTransition: has been accessed by RIVBaseAnimation Class, should be handled by subclass of RIVBaseAnimation");
}

@end
