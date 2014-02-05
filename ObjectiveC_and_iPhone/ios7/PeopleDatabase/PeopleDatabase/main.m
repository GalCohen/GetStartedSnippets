//
//  main.m
//  PeopleDatabase
//
//  Created by Gal Cohen on 2/4/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
//        NSLog(@"Please enter a word");
//        
//        char cstring[40];
//        
//        scanf("%s", cstring);
//        
//        NSString *inputString  = [NSString stringWithCString:cstring encoding:1];
//        
////        NSLog(@"You entered the word %@", inputString);
//        NSLog(@"You entered the word '%@' and it is %li characters long", inputString, [inputString length]);
        
        
        
//        Person *newPerson = [[Person alloc] init];
//        
//        [newPerson enterInfo];
//        [newPerson printInfo];
        
        char response;
        NSMutableArray *people = [[NSMutableArray alloc] init];
        
        do {
            Person *newPerson = [[Person alloc] init];
        
            [newPerson enterInfo];
            [newPerson printInfo];
            
            [people addObject:newPerson];
            
            NSLog(@"Do you want to enter another name? (y/n)");
            scanf("\n%c", &response);
        } while(response == 'y');
    
        NSLog(@"Number of people in the database: %li", [people count]);
        for (Person *onePerson in people) {
            [onePerson printInfo];
        }
    }
    
    
    return 0;
}

