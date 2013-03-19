//
//  Son.m
//  OverridingMethods
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "Son.h"



@implementation Son

- (void) setNum1{
    num1 = 14;
    newVar = 69;
}

- (void) printNumber{
    NSLog(@"%i", num1);
}

@end
