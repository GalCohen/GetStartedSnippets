//
//  main.m
//  Inheritance
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mother : NSObject {
    int a;
    
}

- (void) meth;

@end






@implementation Mother
- (void) meth  {
    a = 50;
}

@end

//--------------------------------------------



@interface Daughter : Mother

-(void) printThing;

@end



@implementation Daughter

-(void) printThing{
    NSLog(@"%i", a);
}

@end


//-----------------------------------------------


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Daughter *Jane = [[Daughter alloc] init];
        
        [Jane meth];
        [Jane printThing];
        
    }
    return 0;
}

