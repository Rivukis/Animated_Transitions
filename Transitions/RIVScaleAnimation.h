//
//  RIVScaleAnimation.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIVBaseAnimationProtocol.h"

@interface RIVScaleAnimation : NSObject <RIVBaseAnimationProtocol>

@property (readonly, nonatomic) NSNumber *defaultDuration;
@property (strong, nonatomic,) NSNumber *customDurationAll;
@property (strong, nonatomic,) NSNumber *customDurationDismiss;
@property (strong, nonatomic,) NSNumber *customDurationPresent;

@property (assign, nonatomic) CGPoint customCenterPoint;

@end
