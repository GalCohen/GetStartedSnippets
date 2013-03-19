//
//  main.m
//  Enum
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>





int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        enum day {m=1 , t, w, h, f};
        
        enum day entry;
        
        
        NSLog(@"Enter a number of the day of the week");
        scanf("%i",  &entry);
        
        switch (entry) {
            case m:
                NSLog(@"That day is monday");
                break;
            case t:
                NSLog(@"That day is tuesday");
                break;
            case w:
                NSLog(@"That day is wednesday");
                break;
            case h:
                NSLog(@"That day is thursday");
                break;
                
            case f:
                NSLog(@"That day is friday");
                break;
                
            default:
                 NSLog(@"not a valid day");
                break;
        }
        
    }
    return 0;
}

