
//
//  RWTScaryBugDatabase.h
//  ScaryBugs
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTScaryBugDatabase : NSObject

+ (NSMutableArray *)loadScaryBugDocs;
+ (NSString *)nextScaryBugDocPath;

@end
