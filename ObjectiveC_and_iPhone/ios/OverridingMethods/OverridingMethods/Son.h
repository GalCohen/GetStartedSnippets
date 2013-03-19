//
//  Son.h
//  OverridingMethods
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mom.h"

@interface Son : Mom{
    int newVar;
    
}
    - (void) setNum1;

    - (void) printNumber;

@end
