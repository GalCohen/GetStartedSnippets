//
//  Person.m
//  SeparatingFiles
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "Person.h"

@implementation Person



- (void) print{
    NSLog(@"i am %i years old and weigh %i poinds", age, weight);
}


/*
- (void) setAge: (int) a {
    age = a;
    
}



- (void) setWeight: (int) w {
    weight = w;
}
*/


- (void) dateAge: (int) a : (int) i {
    NSLog(@"You can date chicks %i years old", (a/2 + 7) - (i/100000));
}


@synthesize weight;
@synthesize age;


@end
