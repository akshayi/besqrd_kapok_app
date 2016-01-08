//
//  CustomAnimationController.h
//  Pop
//
//  Created by PM Foo on 8/12/13.
//  Copyright (c) 2013 Makey Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CustomAnimationController <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval presentationDuration;

@property (nonatomic, assign) NSTimeInterval dismissalDuration;

@property (nonatomic, assign) BOOL isPresenting;

@end
