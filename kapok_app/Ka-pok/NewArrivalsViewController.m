//
//  NewArrivalsViewController.m
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import "NewArrivalsViewController.h"
#import "NewArrivalCell.h"
#import "AppDelegate.h"
#import "CatalogueViewController.h"
#import "Helper.h"

@interface NewArrivalsViewController ()
{
    NSMutableArray *categories;
    NSTimer *timer;
    
    CGFloat scrollScale;
    
    NSString *selection;
    
    int pageIndex;
}

@end

@implementation NewArrivalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = (id) self.collectionView.collectionViewLayout;
    layout.itemSize = self.collectionView.frame.size;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.navController = self.navigationController;
    appDelegate.arrivalsController = self;
    
    categories = [[NSMutableArray alloc] initWithObjects:@"Watches", @"Shoes", @"Jeans", @"Hats & Caps", @"Ties", nil];
    
    scrollScale = 1024;
    
    [self.pageControl setNumberOfPages:categories.count];
    
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;

    __weak id weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    
}

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)recognizer
{
    if(self.navigationController.viewControllers.count > 1)
    {
        return YES;
    }
    
    return NO;
}

- (void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                             target:self
                                           selector:@selector(test)
                                           userInfo:nil
                                            repeats:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
   selection = [[Helper getInstance] getCategory];
    
    if (selection != nil)
    {
        if (timer) {
            [timer invalidate];
        }
        
        NSLog(@"can do refresh... [%@]", selection);
        
        [self performSegueWithIdentifier:@"ShowCatalogue" sender:self];

    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (timer) {
        [timer invalidate];
    }
    
    [self startTimer];
}

- (void)test
{
    
    pageIndex = pageIndex + 1;
    
    NSIndexPath *indexPath;
    
    if (pageIndex > 4) {
        pageIndex = 0;
        
        indexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }else{
        
        indexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
        
        //NSLog(@"[%ld]", (unsigned long)pageIndex);
        
        
        //[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        [self scrollToIndex:pageIndex];
    }
    
    
    [self.pageControl setCurrentPage:pageIndex];
    
    
    
}

- (void)scrollToIndex:(int)index
{
    NSLog(@"scrollToIndex:%ld", (long unsigned)index);
    
    //scrollPoint
    //CGFloat scrollPosition = index * scrollScale;
    //self.collectionView.contentOffset = CGPointMake(scrollPosition, 0);
    
    CGRect bounds = self.collectionView.bounds;
    
    NSLog(@"scrollToIndex:%ld bounds.x:%f", (long unsigned)index, bounds.origin.x);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.fromValue = [NSValue valueWithCGRect:bounds];
    
    if (index > 4) {
        animation.duration = 1.5;
        bounds.origin.x = 0;
    }
    else{
        animation.duration = 0.5;
        bounds.origin.x += 1023.99;
    }
    
    animation.toValue = [NSValue valueWithCGRect:bounds];
    
    [self.collectionView.layer addAnimation:animation forKey:@"bounds"];
    
    self.collectionView.bounds = bounds;
}

#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return categories.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    NewArrivalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *categoryText = [categories objectAtIndex:indexPath.row];
    
    //NSLog(@"%ld - [%@]", (long unsigned)indexPath.row, recentItemDesc);
    
    cell.title.text = categoryText;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [timer invalidate];
    
    selection = [categories objectAtIndex:pageIndex];

    
    [self performSegueWithIdentifier:@"ShowCatalogue" sender:self];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (timer) {
        [timer invalidate];
    }
    
    [self startTimer];
    
    
    //NSLog(@"scrollViewWillEndDecelerating...");
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    pageIndex = (int)page;
    
    [self.pageControl setCurrentPage:pageIndex];
    

    
    
    
    //[scrollView
    
}

- (void)stopTimer
{
    if (timer) {
        [timer invalidate];
    }
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
    
    if ([segue.identifier isEqualToString:@"ShowCatalogue"]) {
        
        
        CatalogueViewController *catalogueController = [segue destinationViewController];
        catalogueController.selection = selection;
    }
    
    
    
}


@end
