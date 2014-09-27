//
//  MTSearchViewController.h
//  Singlecast
//
//  Created by Gal Cohen on 4/16/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSearchViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;

@end
