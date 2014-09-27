//
//  TweetList.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "TweetList.h"

@interface TweetList ()



@end

@implementation TweetList


- (id)initWithJSON:(NSData *)json
{
    self = [super init];
    if (self) {
        NSDictionary *jsonObject= [ NSJSONSerialization JSONObjectWithData:json
                                                                   options:NSJSONReadingMutableLeaves
                                                                     error:nil];
        self.tweetList  = [NSMutableArray new];
        
        for (NSDictionary* item in jsonObject) {
            
            NSString* name = item[@"user"][@"name"];
            NSString* content = item[@"text"];
            Tweet *tweet = [[Tweet alloc] initWithName:name andContent:content];
            
            [self.tweetList addObject:tweet];
        }
    }
    
    self.currentTweetIndex = 0;
    self.isAtTheEnd = NO;
    return self;
}


- (void) printTweets
{
    for (Tweet* tweet in self.tweetList) {
        NSLog(@"%@", [tweet buildTTSReadableString]);
    }
}


- (NSString*) getCurrentTweet
{
    Tweet* tweet = self.tweetList[self.currentTweetIndex];
    return [tweet buildTTSReadableString];
}


- (void) goToNextTweet
{
    self.currentTweetIndex++;
    
    if (self.currentTweetIndex > [self.tweetList count] - 1) {
        self.currentTweetIndex = [self.tweetList count] - 1;
         self.isAtTheEnd = YES;
    }
}


- (void) goToPreviousTweet
{
    self.currentTweetIndex--;
    
    if (self.currentTweetIndex < 0) {
        self.currentTweetIndex = 0;
    }
}


- (NSString*) getTweetAtIndex: (NSInteger)index
{
    Tweet* tweet = self.tweetList[index];
    return [tweet buildTTSReadableString];
}

@end
