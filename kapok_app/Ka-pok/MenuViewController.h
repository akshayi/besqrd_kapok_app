//
//  MenuViewController.h
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryViewTrailing;

@end
