//
//  ViewController.h
//  PickerControl
//
//  Created by Gal Cohen on 10/8/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)displayDay:(id)sender;

@end
