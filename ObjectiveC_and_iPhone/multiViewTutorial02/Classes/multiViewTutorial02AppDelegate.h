//
//  multiViewTutorial02AppDelegate.h
//  multiViewTutorial02
//
//  Created by Gal Cohen on 8/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchClass;


@interface multiViewTutorial02AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	SwitchClass *switchClass;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SwitchClass *switchClass;

@end

