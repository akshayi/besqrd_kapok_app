//
//  InfoViewController.h
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSString *productText;
@property (nonatomic, strong) NSString *productCategory;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)didSelectBack:(id)sender;

@end
