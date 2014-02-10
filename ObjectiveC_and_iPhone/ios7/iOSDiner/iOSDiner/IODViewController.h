//
//  IODViewController.h
//  iOSDiner
//
//  Created by Gal Cohen on 2/10/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IODViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *ibRemoveItemButton;
@property (weak, nonatomic) IBOutlet UIButton *ibAddItemButton;
@property (weak, nonatomic) IBOutlet UIButton *ibPreviousItemButton;
@property (weak, nonatomic) IBOutlet UIButton *ibNextItemButton;
@property (weak, nonatomic) IBOutlet UIButton *ibTotalOrderButton;

@property (weak, nonatomic) IBOutlet UILabel *ibChalkboardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ibCurrentItemImageView;
@property (weak, nonatomic) IBOutlet UILabel *ibCurrentItemLabel;

- (IBAction)ibaRemoveItem:(id)sender;
- (IBAction)ibaAddItem:(id)sender;
- (IBAction)ibaCalculateTotal:(id)sender;
- (IBAction)ibaLoadPreviousItem:(id)sender;
- (IBAction)ibaLoadNextItem:(id)sender;

@end
