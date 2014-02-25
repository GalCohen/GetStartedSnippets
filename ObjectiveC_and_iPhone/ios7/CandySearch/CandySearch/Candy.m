//
//  Candy.m
//  CandySearch
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "Candy.h"

@implementation Candy
@synthesize category;
@synthesize name;

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name
{
    Candy *newCandy = [[self alloc] init];
    newCandy.category = category;
    newCandy.name = name;
    return newCandy;
}

@end