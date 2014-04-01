//
//  Tweet.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


- (NSString*) getFullTweet {
    
    NSString *full = [NSString stringWithFormat:@"%@: %@",self.name, self.content];
    return full;
}


- (Tweet*) initWithName: (NSString*)name andContent:(NSString*) content {
    
    if (self = [super init]) {
        self.name = name;
        self.content = content;
    }
    
    return self;
}

- (NSString*) buildTTSReadableString {
    return [self getFullTweet];
}

@end
