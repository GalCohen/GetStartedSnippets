//
//  PopoverContentViewController.h
//  Popovers with UIPopoverController
//
//  Created by Gal Cohen on 3/19/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverContentViewController : UIViewController

/* We shouldn't define this as strong. That will create a retain cycle
 between the popover controller and the content view controller since the
 popover controller retains the content view controller and the view controller
 will retain the popover controller */
@property (nonatomic, weak) UIPopoverController *myPopoverController;

@end