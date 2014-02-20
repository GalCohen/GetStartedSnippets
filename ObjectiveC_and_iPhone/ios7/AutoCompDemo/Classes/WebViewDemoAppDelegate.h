//
//  WebViewDemoAppDelegate.h
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright Ray Wenderlich 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewDemoAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

