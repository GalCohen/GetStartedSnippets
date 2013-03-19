//
//  main.m
//  Arrays
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *food = [NSArray arrayWithObjects:@"apples",@"bacon", @"corn", @"donut", @"elfs", @"fridge", nil];
        
        NSLog(@"%@", [food objectAtIndex:2]);
        
        for (int i =0; i < [food count]; i++) {
            NSLog(@"%@", [food objectAtIndex:i]);
        }
        
        
        
        
        NSMutableArray *changeme = [NSMutableArray arrayWithCapacity:2];
        [changeme addObject:[NSNumber numberWithInteger:4]];
        
        for (int i = 6; i <100; i+=2) {
            [changeme addObject:[NSNumber numberWithInteger:i]];
        }
        
        for (int x=0; x < [changeme count]; x++) {
              NSLog(@"%li", [[changeme objectAtIndex:x] integerValue]);
        }
        
    }
    return 0;
}

