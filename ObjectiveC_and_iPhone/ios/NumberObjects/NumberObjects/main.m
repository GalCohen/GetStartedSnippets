//
//  main.m
//  NumberObjects
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSNumber *intVar, *floatVar;
        
        intVar = [NSNumber numberWithInteger:142];
        floatVar = [NSNumber numberWithFloat:145.00];
        
        NSLog(@"%li", [intVar integerValue]);
        NSLog(@"%f", [floatVar floatValue]);
        
        
        if ([intVar isEqualToNumber:floatVar] == YES){
            NSLog(@"they are equal!");
        }else{
            NSLog(@"they are not equal..");
        }
        
        
        
        if ([intVar compare:floatVar] == NSOrderedAscending){
            NSLog(@"first number is less");
        }else{
            NSLog(@"first number is greater..");
        }
        
    }
    return 0;
}

