//
//  ViewController.h
//  BasicInteraction
//
//  Created by Gal Cohen on 10/5/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)changeLabel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

- (IBAction)dissmissKeyboard:(id)sender;

@end
