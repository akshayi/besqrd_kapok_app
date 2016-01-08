//
//  AppDelegate.h
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewArrivalsViewController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) NewArrivalsViewController *arrivalsController;
@property (nonatomic, strong) MainViewController *mainController;


@end

