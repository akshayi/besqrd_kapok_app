//
//  SlideUpAnimationController.h
//  Pop
//
//  Created by PM Foo on 8/12/13.
//  Copyright (c) 2013 Makey Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAnimationController.h"
#import <UIKit/UIKit.h>

@interface FadeInAnimationController : NSObject <CustomAnimationController>

@property (nonatomic, assign) NSTimeInterval presentationDuration;

@property (nonatomic, assign) NSTimeInterval dismissalDuration;

@property (nonatomic, assign) BOOL isPresenting;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
