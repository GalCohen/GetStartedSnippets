//
//  PlayersViewController.h
//  Ratings
//
//  Created by Gal Cohen on 2/6/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

#import "PlayerDetailsViewController.h"

@interface PlayersViewController : UITableViewController <PlayerDetailsViewControllerDelegate>

//@interface PlayersViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *players;

@end
