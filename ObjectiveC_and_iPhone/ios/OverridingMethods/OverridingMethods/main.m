//
//  main.m
//  OverridingMethods
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Son.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Son *s = [[Son alloc] init];
        [s setNum1];
        [s printNumber];
        
    }
    return 0;
}

