//
//  MTAppDelegate.h
//  Singlecast
//
//  Created by Gal Cohen on 4/16/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) void (^backgroundSessionCompletionHandler)();

@end
