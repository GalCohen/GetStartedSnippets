//
//  main.m
//  Categories
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Numz.h"

@interface Numz (moreMath)

-(void) subtract : (int)a : (int)b;
-(void) mult : (int)a : (int)b;

@end




@implementation Numz (moreMath)

-(void) subtract : (int)a : (int)b{
    NSLog(@"the numbers subtracted result in %i", a-b);
}

-(void) mult : (int)a : (int)b{
    NSLog(@"the numbers multiplied result in %i", a * b);
}

@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Numz *n = [[Numz alloc] init];
        
        [n mult: 6 : 8];
        [n subtract: 100: 40];
        
    }
    return 0;
}

