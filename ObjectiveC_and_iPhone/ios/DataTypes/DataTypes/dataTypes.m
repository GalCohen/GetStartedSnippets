//
//  main.m
//  DataTypes
//
//  Created by Gal Cohen on 9/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        int i = 20;
        float f = 31.37;
        double d = 9.32e+12;
        char c = 'b';
        
        NSLog(@"%i", i);
        NSLog(@"%f", f);
        NSLog(@"%e", d);
        NSLog(@"%c", c);
        
        int result = 2 + 4 * 5;
        NSLog(@"result is %i", result);
        
        int mod = 38 % 7;
        
        NSLog(@"%i", mod);
        
        
    }
    return 0;
}

