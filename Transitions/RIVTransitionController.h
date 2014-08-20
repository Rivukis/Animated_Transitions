//
//  RIVTransitionController.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIVBaseAnimationProtocol.h"

@interface RIVTransitionController : NSObject
<UIViewControllerTransitioningDelegate,
UINavigationControllerDelegate,
UITabBarControllerDelegate>

- (instancetype)initWithAnimation:(id<RIVBaseAnimationProtocol>)animation;

@property (strong, nonatomic) id<RIVBaseAnimationProtocol> animation;

//@property (strong, nonatomic) id<UINavigationControllerDelegate> navDelegate;

@end
