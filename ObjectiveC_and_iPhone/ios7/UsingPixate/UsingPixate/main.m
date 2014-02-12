//
//  main.m
//  UsingPixate
//
//  Created by Gal Cohen on 2/12/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pixate/Pixate.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        [Pixate licenseKey:@"YOUR LICENSE KEY" forUser:@"YOUR USER NAME"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
