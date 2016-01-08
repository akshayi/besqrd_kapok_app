//
//  ViewController.h
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIView *bufferView;

- (IBAction)didSelectViewMenu:(id)sender;

@end

