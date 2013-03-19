//
//  recordAppDelegate.h
//  record
//
//  Created by Gal Cohen on 11/8/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class recordViewController;

@interface recordAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) recordViewController *viewController;

@end
