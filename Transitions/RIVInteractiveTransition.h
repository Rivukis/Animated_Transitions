//
//  RIVInteractiveTransition.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/19/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIVInteractiveTransition : UIPercentDrivenInteractiveTransition
//<
//UIViewControllerInteractiveTransitioning,
//UIViewControllerAnimatedTransitioning
//>

@property (assign, nonatomic) BOOL isPresenting;

@end
