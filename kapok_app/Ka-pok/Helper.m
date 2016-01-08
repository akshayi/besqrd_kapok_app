//
//  Helper.m
//  Kapok
//
//  Created by Piau Ming Foo on 9/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import "Helper.h"

@implementation Helper


static Helper *helperInstance;

+ (Helper *)getInstance
{
    if (helperInstance == nil) {
        helperInstance = [[super alloc] init];
        
    }
    
    return helperInstance;
}

- (NSString *)getCategory
{
    return category;
}

- (void)setCategory:(NSString *)selection
{
    category = selection;
}

@end
