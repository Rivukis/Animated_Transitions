//
//  RIVBaseAnimationProtocol.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/19/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACTING_ZERO 0.001f

@protocol RIVBaseAnimationProtocol <NSObject, UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL isPresenting;

@end
