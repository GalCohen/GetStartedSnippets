//
//  ButtonsTutorialAppDelegate.h
//  ButtonsTutorial
//
//  Created by Gal Cohen on 8/2/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonsTutorialViewController;

@interface ButtonsTutorialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ButtonsTutorialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ButtonsTutorialViewController *viewController;

@end

