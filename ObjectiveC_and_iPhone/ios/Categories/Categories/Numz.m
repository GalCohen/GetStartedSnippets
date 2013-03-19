//
//  Numz.m
//  Polymorphism
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "Numz.h"

@implementation Numz

- (void) setNumbers:(int)a :(int)b{
    num1 = a;
    num2 = b;
}

- (void)  add{
    answers = num1+num2;
}


- (void) print {
    NSLog(@"I am from the numbers class biotch!, %i", answers);
    
}

@end
