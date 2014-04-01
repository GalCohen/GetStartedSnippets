//
//  TweetList.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "TweetList.h"

@implementation TweetList


- (id)initWithJSON:(NSData *)json
{
    self = [super init];
    if (self) {
        NSDictionary *jsonObject= [ NSJSONSerialization JSONObjectWithData:json
                                                                   options:NSJSONReadingMutableLeaves
                                                                     error:nil];
        
//        self.tweetList = jsonObject;
        self.tweetList  = [NSMutableArray new];
        
        for (NSDictionary* item in jsonObject) {
            
            NSString* name = item[@"user"][@"name"];
            NSString* content = item[@"text"];
            Tweet *tweet = [[Tweet alloc] initWithName:name andContent:content];
            
            [self.tweetList addObject:tweet];
        }
    }
    
    NSLog(@"%@", self.tweetList);
    
    return self;
}


- (void) printTweets
{
    for (Tweet* tweet in self.tweetList) {
        NSLog(@"%@", [tweet getFullTweet]);
    }
}


@end
