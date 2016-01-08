//
//  Helper.h
//  Kapok
//
//  Created by Piau Ming Foo on 9/7/15.
//  Copyright (c) 2015 Shonen Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
{
    NSString *category;
}

+ (Helper *)getInstance;

- (NSString *)getCategory;
- (void)setCategory:(NSString *)selection;

@end
