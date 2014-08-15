//
//  RIVPresentingViewController.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVPresentingViewController.h"
#import "RIVPresentedViewController.h"
#import "RIVTransitionController.h"
#import "RIVSlideAnimation.h"
#import "RIVScaleAnimation.h"
#import "RIVSqueezeAnimation.h"

@interface RIVPresentingViewController ()

@property (strong, nonatomic) RIVTransitionController *transitionController;

@property (strong, nonatomic) RIVBaseAnimation *animation;

@property (strong, nonatomic) RIVTransitionController *slideTransitionController;
@property (strong, nonatomic) RIVTransitionController *scaleTransitionController;
@property (strong, nonatomic) RIVTransitionController *squeezeTransitinoController;

//@property (strong, nonatomic) NSTimer *timer;

@end

@interface RIVPresentingViewController () <UITabBarControllerDelegate>

@end

@implementation RIVPresentingViewController

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
    
    self.title = @"What's Up?";
    
    self.transitionController = self.slideTransitionController;
    self.navigationController.delegate = self.transitionController;
    
    
//    self.animation = [RIVSlideAnimation new];
    self.tabBarController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"hello kitty");
    
}

- (IBAction)presentNewControllerPressed:(UIButton *)sender
{
    RIVPresentedViewController *presentedController = [self.storyboard instantiateViewControllerWithIdentifier:@"PresentedViewController"];
    presentedController.transitioningDelegate = self.transitionController;
    
//    NSLog(@"presentedVC instantiated");
    
    [self presentViewController:presentedController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RIVPresentedViewController *destController = segue.destinationViewController;
    destController.transitioningDelegate = self.transitionController;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSInteger fromVCindex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toVCindex = [tabBarController.viewControllers indexOfObject:toVC];
    
    RIVBaseAnimation *animation = [RIVSlideAnimation new];
    
    if (toVCindex > fromVCindex) {
        animation.isPresenting = YES;
    } else {
        animation. isPresenting = NO;
    }
    
    return animation;
}

- (IBAction)animationChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.transitionController = self.slideTransitionController;
            break;
        case 1:
            self.transitionController = self.scaleTransitionController;
            break;
        case 2:
            self.transitionController = self.squeezeTransitinoController;
            break;
        default:
            break;
    }
    self.navigationController.delegate = self.transitionController;
}

- (RIVTransitionController *)slideTransitionController
{
    if (!_slideTransitionController) {
        RIVSlideAnimation *animation = [RIVSlideAnimation new];
        _slideTransitionController = [[RIVTransitionController alloc] initWithAnimation:animation];
    }
    return _slideTransitionController;
}

- (RIVTransitionController *)scaleTransitionController
{
    if (!_scaleTransitionController) {
        RIVScaleAnimation *animation = [RIVScaleAnimation new];
        _scaleTransitionController = [[RIVTransitionController alloc] initWithAnimation:animation];
    }
    return _scaleTransitionController;
}

- (RIVTransitionController *)squeezeTransitinoController
{
    if (!_squeezeTransitinoController) {
        RIVSqueezeAnimation *animation = [RIVSqueezeAnimation new];
        _squeezeTransitinoController = [[RIVTransitionController alloc] initWithAnimation:animation];
    }
    return _squeezeTransitinoController;
}


@end
