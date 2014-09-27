//
//  CandyTableViewController.h
//  CandySearch
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController  <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *candyArray;

@property (strong,nonatomic) NSMutableArray *filteredCandyArray;
@property IBOutlet UISearchBar *candySearchBar;

-(IBAction)goToSearch:(id)sender;

@end
