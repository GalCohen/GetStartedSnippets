//
//  Tweet.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/31/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "Tweet.h"
#import "TwitterText.h"

@interface Tweet ()

@property NSString* ttsString;

@end

@implementation Tweet


- (NSString*) getFullTweet
{
    
    NSString *full = [NSString stringWithFormat:@"%@: %@",self.name, self.content];
    return full;
}


- (Tweet*) initWithName: (NSString*)name andContent:(NSString*) content
{
    
    if (self = [super init]) {
        self.name = name;
        self.content = content;
    }
    
    return self;
}


- (NSString*) buildTTSReadableString
{
    
    // Used cached copy of text to speech string if available.
    if (self.ttsString) {
        return self.ttsString;
    }
    
    NSString* result = [NSMutableString stringWithString:self.content];
    
    NSArray* entities = [TwitterText entitiesInText:self.content];
    for (int i = 0; i < [entities count]; i++) {
        
        TwitterTextEntity* entity = entities[i];
        TwitterTextEntityType type = entity.type;
        NSRange range = entity.range;
        
        //Get the string that the entity refers to from the full tweet
        NSString* str = [self.content substringWithRange:range];
        
        // replace occurences of the entity such as a url, hashtag or mention in the tweet with a string that the text to speech library can read better.
        if (type == TwitterTextEntityHashtag || type == TwitterTextEntityScreenName) {
            result = [result stringByReplacingOccurrencesOfString:str withString: [self convertHashAndAtToTTSString:str]];

        } else if (type == TwitterTextEntityURL) {
            result = [result stringByReplacingOccurrencesOfString:str withString: [self convertURLtoTTSString]];
            
        } else if (type == TwitterTextEntitySymbol) {
            NSLog(@"HHHHHHHHHHHHHHHHHHHHHHHHHHHHH %@", str);
     
        } else if (type == TwitterTextEntityListName) {
            NSLog(@"GGGGGGGGGGGGGGGGGGGG %@", str);
    
        }
    }

    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString: @"&"];
    result = [result stringByReplacingOccurrencesOfString:@"RT " withString: @"Retweet:"];
    
//    result = [self findAllImageURLs:result];

    result = [NSString stringWithFormat:@"From %@:%@",self.name, result];
    
    self.ttsString = result;
    
    return result;
}


- (NSString*) convertHashAndAtToTTSString: (NSString*)string
{
    
    NSRange prefixRange = NSMakeRange(0, 1);
    NSRange remainingRange = NSMakeRange(1, [string length]  - 1);
    
    NSString* prefix = [string substringWithRange:prefixRange];
    NSString* remaining = [string substringWithRange:remainingRange];
    
    NSString* atSymbol = @"@";
    NSString* hashTagSymbol = @"#";
    
    if ([prefix isEqualToString:atSymbol]) {
        return [NSString stringWithFormat:@"%@%@", @"at:", remaining];
    }
    
    if ([prefix isEqualToString:hashTagSymbol]) {
        return [NSString stringWithFormat:@"%@%@", @"hashtag:", remaining];
    }
    
    return @"";
}


- (NSString*) convertURLtoTTSString
{
    return @":link";
}


//- (NSString*) convertImgUrlToTTSString
//{
//    
//    return @":image";
//}


//- (NSString*) findAllImageURLs: (NSString*) string
//{
//
//    // seperate tweet into array of words
//    NSArray* words = [string componentsSeparatedByString:@" "];
//    NSLog(@"%@", words);
//    NSString* imgUrlStart = @"http://t.co/";
//    
//    // iterate over the array of words looking for words containing the twitter's image url
//    for (int i = 0; i < [words count]; i++) {
//        
//        NSRange range = [words[i] rangeOfString:imgUrlStart];
//        
//        // check the range exists, meaning that a twitter image url is found within the word,
//        if (range.location != NSNotFound) {
//            
//            // get the word from the original tweet based on the range found
//            NSString* str = [string substringWithRange:range];
//            NSLog(@"%@", str);
//            // remove occurences of the image url in the original tweet replacing it with a text to speech readable version
//            string = [string stringByReplacingOccurrencesOfString:str withString: [self convertImgUrlToTTSString]];
//            
//        }
//    }
//    
//    return string;
//}


@end
