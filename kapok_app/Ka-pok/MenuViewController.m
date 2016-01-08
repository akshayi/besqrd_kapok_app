//
//  MenuViewController.m
//  Ka-pok
//
//  Created by Piau Ming Foo on 10/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import "MenuViewController.h"
#import "CategoryCell.h"
#import "CategorySectionHeader.h"
#import "Helper.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
{
    NSMutableDictionary *dict;
    NSArray *headers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad");
    
    self.bgView.alpha = 0;
    
    self.categoryViewTrailing.constant = -self.categoryView.frame.size.width;
    [self.view layoutIfNeeded];
    
    [self makeCategory];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC:)];
    [self.bgView addGestureRecognizer:tapGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self showSearchNavigationBarTransition];
}

- (void)showSearchNavigationBarTransition
{
    
    self.categoryViewTrailing.constant = 0;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.35 delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.45f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [self.view layoutIfNeeded];
        self.bgView.alpha = 1.0;
        
        
    } completion:^(BOOL finished) {
        
        
        //[self.memoTableView reloadData];
    }];

}

- (void)dismissVC:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.categoryViewTrailing.constant = -self.categoryView.frame.size.width;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.35 delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.45f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        
        //[self.memoTableView reloadData];
    }];
    
    
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [headers count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [headers objectAtIndex:section];
    return sectionName;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"SectionHeader";
    CategorySectionHeader *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *sectionName = [headers objectAtIndex:section];
    headerView.categoryHeaderLabel.text = sectionName;
    
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [headers objectAtIndex:section];
    NSArray *itemsArray = [dict objectForKey:key];
    
    return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( cell == nil ) {
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    
    NSUInteger i = [indexPath section];
    NSString *header = [headers objectAtIndex:i];
    NSArray *array = [dict objectForKey:header];
    
    NSString *e = [array objectAtIndex:indexPath.row];
    cell.categoryLabel.text = e;
    
    
    return cell;
}

- (void)makeCategory
{
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *pathToFile = [mainBundle pathForResource: @"category" ofType: @"csv"];
    
    NSError * error = nil;
    NSString *fileContents=[NSString stringWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:&error];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys: nil];
    
    if (error == nil)
    {
        NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (int i=0; i<lines.count; i++)
        {
            NSString * currLine = (NSString *)[lines objectAtIndex:i];
            NSArray *itemComponents = [currLine componentsSeparatedByString: @"|"];
            
            NSString *header = [itemComponents objectAtIndex:0];
            NSString *category = [itemComponents objectAtIndex:1];
            
            NSMutableArray *categories;
            
            if ([dict valueForKey:header] != nil)
            {
                categories = (NSMutableArray *)[dict objectForKey:header];
            }
            else
            {
                categories = [[NSMutableArray alloc] initWithObjects: nil];
            }
            
            [categories addObject:category];
            [dict setObject:categories forKey:header];
        }
        
        headers = [dict allKeys];
        headers = [headers sortedArrayUsingSelector:@selector(compare:)];
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = [indexPath section];
    NSString *header = [headers objectAtIndex:i];
    NSArray *array = [dict objectForKey:header];
    
    NSString *selection = [array objectAtIndex:indexPath.row];

    [[Helper getInstance] setCategory:selection];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.mainController.bufferView.hidden = NO;
    
   


    
    

    
   
     appDelegate.mainController.bufferView.alpha = 0.0;
     appDelegate.mainController.bufferView.hidden = NO;
     
     [UIView animateWithDuration:0.05 animations:^{
     appDelegate.mainController.bufferView.alpha = 1.0;
     
     
     } completion:^(BOOL finished){
         
         [self dismissViewControllerAnimated:YES completion:nil];
         
         [appDelegate.navController popToRootViewControllerAnimated:NO];

     }];
    
//
//    
//    
//    appDelegate.mainController.bufferView.alpha = 1.0;
//    appDelegate.mainController.bufferView.hidden = NO;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
