//
//  RIVCellToDetailAnimation.h
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVBaseAnimation.h"

@interface RIVCellToDetailAnimation : RIVBaseAnimation

@property (readonly, nonatomic) NSNumber *defaultDuration;
@property (strong, nonatomic,) NSNumber *customDurationAll;
@property (strong, nonatomic,) NSNumber *customDurationDismiss;
@property (strong, nonatomic,) NSNumber *customDurationPresent;

@property (strong, nonatomic) UIImageView *cellImageView;
@property (assign, nonatomic) CGRect cellImageCorrectedFrame; // Frame in Main View (not UICollectionView, etc.)
@property (strong, nonatomic) UIImageView *detailImageView;
@property (assign, nonatomic) CGRect detailImageCorrectedFrame; // Frame in Main View (not SubView, etc.)

@end
