//
//  RIVTransitionController.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVBaseAnimation;

@interface RIVTransitionController : NSObject
<UIViewControllerTransitioningDelegate,
UINavigationControllerDelegate,
UITabBarControllerDelegate>

- (instancetype)initWithAnimation:(RIVBaseAnimation *)animation;

@property (strong, nonatomic) RIVBaseAnimation *animation;

//@property (strong, nonatomic) id<UINavigationControllerDelegate> navDelegate;

@end
