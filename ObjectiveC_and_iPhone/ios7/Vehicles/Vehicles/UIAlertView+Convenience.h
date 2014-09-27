//
//  UIAlertView+Convenience.h
//  Vehicles
//
//  Created by Gal Cohen on 2/5/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIAlertView (Convenience)

// Shows a UIAlertView with the given title and message, and an OK button to dismiss it.
+ (void)showSimpleAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
