//
//  CatalogueViewController.h
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogueViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSString *selection;
@property (weak, nonatomic) IBOutlet UILabel *selectionLabel;

- (IBAction)didSelectBack:(id)sender;

@end
