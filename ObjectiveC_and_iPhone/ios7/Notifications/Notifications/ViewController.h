//
//  ViewController.h
//  Notifications
//
//  Created by Gal Cohen on 2/26/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)postNotificationWithString:(NSString *)orientation;
- (void)useNotificationWithString:(NSNotification*)notification;

@end
