//
//  firstTestAppDelegate.h
//  firstTest
//
//  Created by Gal Cohen on 8/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class firstTestViewController;

@interface firstTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    firstTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet firstTestViewController *viewController;

@end

