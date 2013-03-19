//
//  main.m
//  scanf
//
//   Created by Gal Cohen on 9/13/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int i, userNum;
        
        NSLog(@"Enter a number and I will print it out?");
        scanf("%i" , &userNum );
        
        for (i = 1; i < userNum; i++) {
            NSLog(@"%i", i);
        }
        
        
    }
    return 0;
}

