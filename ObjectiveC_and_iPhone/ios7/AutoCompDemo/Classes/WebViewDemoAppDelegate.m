//
//  WebViewDemoAppDelegate.m
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright Ray Wenderlich 2009. All rights reserved.
//

#import "WebViewDemoAppDelegate.h"

@implementation WebViewDemoAppDelegate

@synthesize window;
@synthesize navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  [window addSubview: navController.view];
  [window makeKeyAndVisible];
}

- (void)dealloc {
  [window release];
  [navController release];
  [super dealloc];
}

@end
