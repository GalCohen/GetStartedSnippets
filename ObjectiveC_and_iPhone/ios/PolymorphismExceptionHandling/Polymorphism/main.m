//
//  main.m
//  Polymorphism
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//


//polymorphism
// try and catch statements

#import <Foundation/Foundation.h>

#import "Numz.h"
#import "Charz.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //NSLog(@"TEST TEST");
        
        id tuna;
        
        Numz *n = [[Numz alloc] init];
        Charz *c = [[Charz alloc] init];
        
        
        [n setNumbers:8 :10];
        [n add];
        [n print];
        
        [c setCharz];
        [c add];
        [c print];
        
        
        
        tuna = n;
        [tuna print];
        
        tuna = c;
        [tuna print];
        
        
        @try {
            [n print];
        }
        @catch (NSException *exception) {
            NSLog(@"an error occurred here");
        }
        @finally {
            
        }
        
        
        
        //NSLog(@"TEST TEST");
        
    }
    return 0;
}

