//
//  rotationTutorialAppDelegate.h
//  rotationTutorial
//
//  Created by Gal Cohen on 8/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class rotationTutorialViewController;

@interface rotationTutorialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    rotationTutorialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet rotationTutorialViewController *viewController;

@end

