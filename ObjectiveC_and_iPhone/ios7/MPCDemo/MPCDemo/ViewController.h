//
//  ViewController.h
//  MPCDemo
//
//  Created by Gal Cohen on 4/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtGuess;
@property (weak, nonatomic) IBOutlet UITextView *tvHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)startGame:(id)sender;
- (IBAction)sendGuess:(id)sender;
- (IBAction)cancelGuessing:(id)sender;


@end
