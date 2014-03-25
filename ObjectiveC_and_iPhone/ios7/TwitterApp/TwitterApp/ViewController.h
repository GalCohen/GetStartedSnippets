//
//  ViewController.h
//  TwitterApp
//
//  Created by Gal Cohen on 3/24/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;

@property (strong, nonatomic) NSArray *dataSource;

@end