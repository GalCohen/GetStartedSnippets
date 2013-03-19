//
//  main.m
//  Rectangle
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Rectangle.h"
#import "XYPoint.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //Rectangle *myRect = [[Rectangle alloc] init];
        
        //[myRect setWH: 6 :8];
        
        // NSLog(@"Rectangle is %i by %i", myRect.width, myRect.height);
        //NSLog(@"Area = %i, Perimieter = %i", [myRect area], [myRect perimeter]);
        
        
        

        //Square *mySq = [[Square alloc] init];
        //[mySq setSide:6];
        
        //NSLog(@"One side is %i", [mySq side]);
        //NSLog(@"Area = %i, Perimieter = %i", [mySq area], [mySq perimeter ]);
        
        
        Rectangle *r = [[Rectangle alloc] init];
        XYPoint *p = [[XYPoint alloc] init];
        
        [p setXY:100: 300];
        
        r.origin = p;
        [r setWH:6 : 8 ];
        
        NSLog(@"width and height is %i %i", r.width, r.height);
        NSLog(@"Origin is at %i,%i", r.origin.x, r.origin.y);
        NSLog(@"Area and perimeter are %i and %i", [r area], [r perimeter]);
        
    }
    return 0;
}

