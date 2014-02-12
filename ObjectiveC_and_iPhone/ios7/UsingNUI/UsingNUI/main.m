//
//  main.m
//  UsingNUI
//
//  Created by Gal Cohen on 2/12/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NUISettings.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        [NUISettings initWithStylesheet:@"test"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
