//
//  ViewController.h
//  UIComponents
//
//  Created by Gal Cohen on 3/17/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property UIAlertView* alertView;
@property UISwitch* switchElement;
@property UIPickerView* picker;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UISlider *slider;

@end
