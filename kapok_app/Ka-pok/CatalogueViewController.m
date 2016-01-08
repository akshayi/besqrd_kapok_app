//
//  CatalogueViewController.m
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import "CatalogueViewController.h"
#import "Helper.h"
#import "ProductCell.h"
#import "InfoViewController.h"
#import "AppDelegate.h"

@interface CatalogueViewController ()

@end

@implementation CatalogueViewController
{
    NSArray *array;
    NSString *productText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[Helper getInstance] setCategory:nil];
    
    array = [[NSArray alloc] initWithObjects:@"Product 1", @"Product 2", @"Product 3", @"Product 4", @"Product 5", nil];

    
    self.selectionLabel.text = self.selection;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    //appDelegate.mainController.bufferView.alpha = 0;
    //appDelegate.mainController.bufferView.hidden = YES;
    
    
    
    appDelegate.mainController.bufferView.hidden = NO;
    
    [UIView animateWithDuration:0.05 animations:^{
        appDelegate.mainController.bufferView.alpha = 0.0;
    
    
    } completion:^(BOOL finished){
    
    appDelegate.mainController.bufferView.hidden = YES;
    }];
    
    
    
    
    
    
    
    
}

#pragma mark - UICollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get collection cell
    static NSString *identifier = @"Cell";
    
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    NSString *text = [array objectAtIndex:indexPath.row];
    
    cell.layer.cornerRadius = 20.0f;
    cell.productLabel.text = text;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    productText = [array objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowInfo" sender:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ShowInfo"])
    {
        InfoViewController *infoController = [segue destinationViewController];
        infoController.productText = productText;
        infoController.productCategory = self.selection;
    }
}


- (IBAction)didSelectBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
