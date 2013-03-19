//
//  LoginTutorialAppDelegate.h
//  LoginTutorial
//
//  Created by Gal Cohen on 8/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginTutorialViewController;

@interface LoginTutorialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LoginTutorialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LoginTutorialViewController *viewController;

@end

