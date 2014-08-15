//
//  RIVPresentedViewController.m
//  Transitions
//
//  Created by Brian Radebaugh on 8/14/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVPresentedViewController.h"

@interface RIVPresentedViewController ()

@end

@implementation RIVPresentedViewController

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
//    self.title = @"Hello Peeps.";
    
//    NSLog(@"PD view did load");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 350, 150, 50)];
    view.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    label.text = @"view did load";
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    [self.view addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"PD view will appear");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 400, 150, 50)];
    view.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    label.text = @"view will appear";
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    [self.view addSubview:view];
}

- (void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"PD view did appear");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 450, 150, 50)];
    view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    label.text = @"view did appear";
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    [self.view addSubview:view];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.transitioningDelegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)popViewControllerPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
