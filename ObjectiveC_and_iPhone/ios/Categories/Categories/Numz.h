//
//  Numz.h
//  Polymorphism
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Numz : NSObject{
    int num1;
    int num2;
    int answers;
    
}

- (void) setNumbers: (int)a: (int)b;
- (void)  add;
- (void) print;



@end
