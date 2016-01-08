//
//  ViewController.m
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import "MainViewController.h"
#import "FadeInAnimationController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@property (nonatomic, strong) id<CustomAnimationController> animationController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.mainController = self;
    
    self.bufferView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectViewMenu:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.arrivalsController stopTimer];
    
    
    [self performSegueWithIdentifier:@"ShowMenu" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMenu"])
    {
        
        MenuViewController *menuViewController = segue.destinationViewController;
        
        self.animationController = [[FadeInAnimationController alloc] init];
        menuViewController.transitioningDelegate = self;
        menuViewController.modalPresentationStyle = UIModalPresentationCustom;
        self.animationController.presentationDuration = 0.35f;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    self.animationController.isPresenting = YES;
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [self.navigationController setModalPresentationStyle:UIModalPresentationNone];
    self.animationController.isPresenting = NO;
    return self.animationController;
}

@end
