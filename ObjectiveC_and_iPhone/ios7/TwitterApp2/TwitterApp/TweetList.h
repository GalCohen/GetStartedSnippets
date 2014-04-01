//
//  TweetList.h
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

@interface TweetList : NSObject

@property NSMutableArray* tweetList;
@property BOOL isAtTheEnd;

- (id) initWithJSON: (NSData*) json;
- (void) printTweets;

- (NSString*) getCurrentTweet;
- (void) goToNextTweet;
- (void) goToPreviousTweet;
- (NSString*) getTweetAtIndex: (NSInteger)index;

@end
