//
//  main.m
//  IntFloatConversions
//
//  Created by Gal Cohen on 9/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

// int and float conversions
// type casting and assignment operators


#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        float f1 = 20.86;
        float f2;
        int i1;
        int i2 = 15, i3 = 10;
        
        i1 = f1;
        NSLog(@"%i", i1);
        
        f2 = i2/i3;
        NSLog(@"%f", f2);
        
        
        f2 = f1/i2;
        NSLog(@"%f", f2);
        
        
        f2 = (float) i3/8;
        NSLog(@"%f", f2);
        
        int gal = (int) 26.77;
        NSLog(@"%i", gal);
        
        gal = gal + 5;
        NSLog(@"%i", gal);
        
        gal += 5;
        NSLog(@"%i", gal);
        
        gal *= 5;
        NSLog(@"%i", gal);
        
        
    }
    return 0;
}

