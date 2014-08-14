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

@interface RIVPresentingViewController ()

@property (strong, nonatomic) RIVTransitionController *transitionController;

//@property (strong, nonatomic) NSTimer *timer;

@end

@interface RIVPresentingViewController ()

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
    
    RIVSlideAnimation *animation = [RIVSlideAnimation new];
    
    
    
    self.transitionController = [[RIVTransitionController alloc] initWithAnimation:animation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)presentNewControllerPressed:(UIButton *)sender
{
    RIVPresentedViewController *presentedController = [self.storyboard instantiateViewControllerWithIdentifier:@"PresentedViewController"];
    presentedController.transitioningDelegate = self.transitionController;
    
    [self presentViewController:presentedController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RIVPresentedViewController *destController = segue.destinationViewController;
    destController.transitioningDelegate = self.transitionController;
}

@end
