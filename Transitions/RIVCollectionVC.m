//
//  RIVCollectionVC.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVCollectionVC.h"
#import "RIVCustomCollectionCell.h"
#import "RIVTransitionController.h"
#import "RIVCellToDetailAnimation.h"
#import "RIVCollectionDetailVC.h"

@interface RIVCollectionVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) RIVTransitionController *transitionController;
@property (strong, nonatomic) RIVCellToDetailAnimation *animation;

@end

@implementation RIVCollectionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.animation = [RIVCellToDetailAnimation new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UICollectionView Delegate && Data Source


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RIVCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 1) {
        cell.imageView.image = [UIImage imageNamed:@"Avater"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"man-avatar-1"];
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RIVCustomCollectionCell *cell = (RIVCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    // Setup New VC
    RIVCollectionDetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionDetailVC"];
    detailVC.view = detailVC.view; // This is to ensure that detailVC.view will be lazily instantiated
    
    // Setup Animation
    self.animation.cellImageView = cell.imageView;
    self.animation.detailImageView = detailVC.imageView;
    
    // Setup Transition Controller
    self.transitionController = [[RIVTransitionController alloc] initWithAnimation:self.animation];
    detailVC.transitioningDelegate = self.transitionController;
    
    // Present New VC
    [self presentViewController:detailVC animated:YES completion:nil];
}



@end
