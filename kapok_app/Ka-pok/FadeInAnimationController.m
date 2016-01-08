//
//  SlideUpAnimationController.m
//  Pop
//
//  Created by PM Foo on 8/12/13.
//  Copyright (c) 2013 Makey Design. All rights reserved.
//

#import "FadeInAnimationController.h"

@implementation FadeInAnimationController

-(id)init {
    self = [super init];
    
    if (self) {
        //self.presentationDuration = 0.35; // 1.0
        self.dismissalDuration = 0.3; // 1.0
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return self.isPresenting ? self.presentationDuration : self.dismissalDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.isPresenting) {
        // NSLog(@"Presenting Share");
        [self executePresentationAnimation:transitionContext];
    }
    else {
        // NSLog(@"Share option selected");
        [self executeDismissalAnimation:transitionContext];

    }
    
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [inView addSubview:toViewController.view];
    
    //fromViewController.view.alpha = 0.7;
    [transitionContext completeTransition:YES];
    
    //[[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
    
    /*
    CGPoint centerOffScreen = inView.center;
    centerOffScreen.y = (1)*inView.frame.size.height;
    toViewController.view.center = centerOffScreen;
    
    [UIView animateWithDuration:self.presentationDuration delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toViewController.view.center = inView.center;
        fromViewController.view.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        //[[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
    }];
     */
}


-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //NSLog(@"fadein executeDismissalAnimation...");
    
    UIView* inView = [transitionContext containerView];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    toViewController.view.alpha = 1.0;
    [inView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
 
    //CGPoint centerOffScreen = inView.center;
    //centerOffScreen.y = (1)*inView.frame.size.height + 20;
    
    //[transitionContext completeTransition:YES];
    //[[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
    

    [UIView animateWithDuration:0.35 delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{

        fromViewController.view.alpha = 0.0; //1.0
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        [[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
   
        
    }];

}


@end
