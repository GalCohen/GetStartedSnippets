//
//  Person.h
//  SeparatingFiles
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {

    int age;
    int weight;
}

@property int age, weight;

- (void) print;
// - (void) setAge: (int) a;  these will be synthesized by the compiler
// - (void) setWeight: (int) w;

- (void) dateAge: (int) a: (int) i ;

@end
