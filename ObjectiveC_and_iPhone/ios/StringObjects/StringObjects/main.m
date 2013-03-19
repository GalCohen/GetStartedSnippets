//
//  main.m
//  StringObjects
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//


//strings and mutable strings

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *s = @"cats dont like bananas";
        NSString *tester;
        
        NSLog(@"%@", s);
        
        
        NSNumber *n = [NSNumber numberWithInteger:120];
        
        NSLog(@"length of string is:%lu", [s length]);
        
        
        tester = [NSString stringWithString:s]; //copy the string s into tester;
        NSLog(@"copied string is:%@", tester);
        
        
        tester = [s uppercaseString]; //copy the string s into tester;
        NSLog(@"uppercase string is:%@", tester);
        
        
        
        
        s = @"cats dont like bananas";
        NSString *d = @"dont feed grapes to dogs!";
       
        tester = [d substringToIndex:10];
        NSLog(@"%@", tester);
        
        tester = [d substringFromIndex:5];
        NSLog(@"%@", tester);
        
        
        tester = [d substringWithRange:NSMakeRange(5, 11)];
        NSLog(@"%@", tester);
        
        
        
        NSRange range = [d rangeOfString:@"grapes"];
        NSLog(@"Location is %li and length is %li", range.location, range.length);
        
        
        //-------------------------------------- Mutables ---------------------------------------
        
        
        NSString *dog = @"hotdog? I thought you said pumpkin!";
        NSMutableString *mute;
        
        mute = [NSMutableString stringWithString:dog];
        
        NSLog(@"%@", mute);
        
        
        [mute insertString:@" sauce" atIndex:6];
        NSLog(@"%@", mute);
        
        [mute appendString:@" My bad!"];
        NSLog(@"%@", mute);
        
        
        [mute deleteCharactersInRange:NSMakeRange(12, 20)];
        NSLog(@"%@", mute);
        
        
        [mute setString: @"I am a new String mofo!"];
        NSLog(@"%@", mute);
        
        [mute replaceCharactersInRange:NSMakeRange(11, 12) withString:@"mother!"];
        NSLog(@"%@", mute);
        
        NSString *old = @"mother";
        NSString *new = @"baby seal";
        NSRange therange = [mute rangeOfString:old];
        
        [mute replaceCharactersInRange: therange withString:new];
         NSLog(@"%@", mute);
    }
    
    return 0;
}

