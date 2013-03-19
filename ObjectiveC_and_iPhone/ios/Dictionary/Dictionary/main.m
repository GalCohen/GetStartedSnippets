//
//  main.m
//  Dictionary
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:@"when you spray yourself with febreeze" forKey:@"febreeze shower"];
        [dic setObject:@"gamer who lacks experience" forKey:@"noob"];
        [dic setObject:@"best food on the planet" forKey:@"sushi"];
        
        
        NSLog(@"%@", [dic objectForKey:@"noob"]);
        
    }
    return 0;
}

