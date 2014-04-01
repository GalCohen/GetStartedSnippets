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
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController 


@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;

@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *speakButton;
- (IBAction)speakButtonPressed:(id)sender;

@end