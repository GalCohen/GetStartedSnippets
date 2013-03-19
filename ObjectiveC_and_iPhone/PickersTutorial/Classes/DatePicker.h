//
//  DatePicker.h
//  PickersTutorial
//
//  Created by Gal Cohen on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DatePicker : UIViewController {
	UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

-(IBAction) pressButton;

@end
