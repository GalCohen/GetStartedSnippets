//
//  Person.h
//  PeopleDatabase
//
//  Created by Gal Cohen on 2/4/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *firstName;
    NSString *lastName;
    int age;
}

- (void)enterInfo;
- (void)printInfo;

@end
