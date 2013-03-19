//
//  main.m
//  Scope
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//


//scope directives
//global and external variables
// enum data types

#import <Foundation/Foundation.h>


int gDrunk = 21;  //global variable  
static int gx = 0;


@interface Tuna : NSObject{
@private
    char c1;
    int x;
@protected
    int h;
    int e;
}


- (void) addOne;
- (void) printIt;

@end




@implementation Tuna

    - (void) changeVar{
        extern int gDrunk;
        gDrunk = 18;
    }


    - (void) addOne{
        gx++;
        
    }


    - (void) printIt{
        NSLog(@"gx:%i", gx);
    }

@end




int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSLog(@"%i", gDrunk);
        
        Tuna *t= [[Tuna alloc] init];
        [t changeVar];
        
        NSLog(@"%i", gDrunk);
        
        
        
        Tuna *fish = [[Tuna alloc] init];
        [fish addOne];
        [fish printIt];
        [t addOne];
        [fish printIt];
        
        
        enum day {mon=1, tue, wed, thu, fri, sat, sun};
        
        enum day today = wed;
        
    }
    return 0;
}

