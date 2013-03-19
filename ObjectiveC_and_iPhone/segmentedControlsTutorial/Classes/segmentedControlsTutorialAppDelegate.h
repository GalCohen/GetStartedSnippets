//
//  segmentedControlsTutorialAppDelegate.h
//  segmentedControlsTutorial
//
//  Created by Gal Cohen on 8/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class segmentedControlsTutorialViewController;

@interface segmentedControlsTutorialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    segmentedControlsTutorialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet segmentedControlsTutorialViewController *viewController;

@end

