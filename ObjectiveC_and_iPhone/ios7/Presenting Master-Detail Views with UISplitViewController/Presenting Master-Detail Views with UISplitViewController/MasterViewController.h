//
//  MasterViewController.h
//  Presenting Master-Detail Views with UISplitViewController
//
//  Created by Gal Cohen on 3/19/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
