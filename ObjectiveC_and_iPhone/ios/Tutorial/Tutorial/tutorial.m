//
//  main.m
//  Tutorial
//
//  Created by Gal Cohen on 9/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
    int age;
    int weight;
}

- (void) print;
- (void) setAge: (int) a;
- (void) setWeight: (int) w;

@end




@implementation Person

-(void) print {
    NSLog(@"I am %i years old and weigh %i pounds", age, weight);
}

-(void) setAge:(int)a {
    age=a;
}


-(void)setWeight:(int)w {
    weight=w;
}

-(int) age {
    return age;
}

- (int) weight {
    return weight;
}

@end

// creating and using objects

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int n1 = 20;
        int n2 = 42;
    
        NSLog(@"Hello, World! this is n1:%i and this is n2:%i", n1, n2);
        
        // ----
        
        Person *galcohen = [Person alloc];
        galcohen = [galcohen init];
        
        [galcohen setAge: 21];
        [galcohen setWeight:156];
        
        [galcohen print];
        
        
        Person *roy = [[Person alloc] init];
        [roy setAge:18];
        [roy setWeight:120];
        
        [roy print];
        
        
        NSLog(@"gal is %i and roy is %i, they weigh %i and %i, respectively", [galcohen age] , [roy age],[galcohen weight], [roy weight] );
        
    }
    return 0;
}








