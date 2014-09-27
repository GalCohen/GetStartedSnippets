//
//  Tweet.h
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property NSString* name;
@property NSString* content;

- (NSString*) getFullTweet;
- (Tweet*) initWithName: (NSString*)name andContent:(NSString*) content;
- (NSString*) buildTTSReadableString;

@end
