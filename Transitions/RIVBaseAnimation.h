//
//  RIVBaseAnimation.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIVBaseAnimation : NSObject
<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL isPresenting;

@end
