//
//  RWTScaryBugData.h
//  ScaryBugs
//
//  Created by Gal Cohen on 2/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTScaryBugData : NSObject  <NSCoding>

@property (strong) NSString *title;
@property (assign) float rating;

- (id)initWithTitle:(NSString*)title rating:(float)rating;


@end