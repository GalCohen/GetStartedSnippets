//
//  main.m
//  SeparatingFiles
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

//importing classes
//synthesized accessor methods


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *bucky = [[Person alloc] init];
        
        //[bucky setAge:23];
        //[bucky setWeight:350];
        
        bucky.age = 12; //can be used once sythenized accessor methods are made.
        bucky.weight = 540;
        
        
        [bucky print];
        
        [bucky dateAge: 45:540000];
        
       
        
        
    }
    return 0;
}

