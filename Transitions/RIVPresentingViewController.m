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

//#import "RIVInteractiveTransition.h"

@interface RIVPresentingViewController ()

@property (strong, nonatomic) RIVTransitionController *transitionController;

@property (strong, nonatomic) RIVTransitionController *slideTransitionController;
@property (strong, nonatomic) RIVTransitionController *scaleTransitionController;
@property (strong, nonatomic) RIVTransitionController *squeezeTransitinoController;

//@property (strong, nonatomic) RIVInteractiveTransition *interactiveAnimation;

//@property (strong, nonatomic) NSTimer *timer;

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
    self.tabBarController.delegate = self.slideTransitionController;
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandler:)];
    edgePan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)gestureHandler:(UIScreenEdgePanGestureRecognizer *)edgePan
{
    CGPoint location = [edgePan locationInView:self.view];
    double percentCompleted = (320.0f - location.x) / 320.0f;
    
    switch (edgePan.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"begin");
            NSLog(@"%f", percentCompleted);
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"%f", percentCompleted);
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"%f", percentCompleted);
            NSLog(@"ended");
            break;
        default:
            break;
    }
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

- (IBAction)animationChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:     self.transitionController = self.slideTransitionController;     break;
        case 1:     self.transitionController = self.scaleTransitionController;     break;
        case 2:     self.transitionController = self.squeezeTransitinoController;   break;
    }
    self.navigationController.delegate = self.transitionController;
}


# pragma mark - Lazy Instantiation


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
//        animation.customCenterPoint = CGPointMake(320, 0);
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
