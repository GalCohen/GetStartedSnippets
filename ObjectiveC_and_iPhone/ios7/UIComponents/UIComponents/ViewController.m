//
//  ViewController.m
//  UIComponents
//
//  Created by Gal Cohen on 3/17/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *displaySecondViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"1st ViewController";
    self.displaySecondViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displaySecondViewController setFrame:CGRectMake(10, 500, 0, 0)];
    
    [self.displaySecondViewController setTitle:@"Display Second View Controller"
                                      forState:UIControlStateNormal];
    
    [self.displaySecondViewController sizeToFit];
    
    [self.displaySecondViewController addTarget:self
                                         action:@selector(performDisplaySecondViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displaySecondViewController];
    
    
    // Alert
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:@"Choose between these two buttons"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok", nil];
    [self.alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [self.alertView show];
    
    
    
    // Switch
    self.switchElement = [[UISwitch alloc] initWithFrame:CGRectMake(20, 70, 0, 0)];
    [self.switchElement setOn:YES animated:YES];
//    switchElement.center = self.view.center; // center the element
    [self.view addSubview:self.switchElement];
    
    self.switchElement.tintColor = [UIColor redColor];
    self.switchElement.onTintColor = [UIColor brownColor];
    self.switchElement.thumbTintColor = [UIColor greenColor];
    
    // programmataically connection actions
    [self.switchElement addTarget:self action:@selector(switchIsChanged:)
              forControlEvents:UIControlEventValueChanged];
    
    
    // Picker
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 0, 0)];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self.view addSubview:self.picker];
    
    
    // Date Picker
    self.datePicker = [[UIDatePicker alloc] init];
    CGPoint point = CGPointMake(self.view.center.x, self.view.center.y + 70);
    self.datePicker.center = point;
    
    //date picker countdown timer with 2 min duration
    
    self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    NSTimeInterval twoMinutes = 2 * 60;
    [self.datePicker setCountDownDuration:twoMinutes];
    [self.view addSubview:self.datePicker];
    NSLog(@"%f", self.datePicker.countDownDuration);
    
    /*
    // date picker with min and max amounts
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.view addSubview:self.datePicker];
    
    // programmataically connection actions
    [self.datePicker addTarget:self action:@selector(datePickerDateChanged:)
                forControlEvents:UIControlEventValueChanged];
    
    // set a minimum and maximum dates for the date picker
    NSTimeInterval oneYearTime = 365 * 24 * 60 * 60;
    NSDate *todayDate = [NSDate date];
    NSDate *oneYearFromToday = [todayDate dateByAddingTimeInterval:oneYearTime];
    NSDate *twoYearsFromToday = [todayDate dateByAddingTimeInterval:2 * oneYearTime];
    
    self.datePicker.minimumDate = oneYearFromToday;
    self.datePicker.maximumDate = twoYearsFromToday;
    */
    
    
    // Slider
//    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(50,
//                                                             50,
//                                                             200.0f,
//                                                             23.0f)];
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 450, 200.0f, 23.0f)];
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = 100.0f;
    self.slider.value = self.slider.maximumValue / 2.0;
    [self.view addSubview:self.slider];
    
    // Fire callback only when movement is done instead of constantly during movement.
    self.slider.continuous = NO;
    
    [self.slider addTarget:self action:@selector(sliderValueChanged:)
          forControlEvents:UIControlEventValueChanged];
    
    /* Set the tint color of the minimum value */
    self.slider.minimumTrackTintColor = [UIColor redColor]; /* Set the tint color of the thumb */
    self.slider.maximumTrackTintColor = [UIColor greenColor]; /* Set the tint color of the maximum value */
    self.slider.thumbTintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AlertView

// callback for an alertview
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel Button Clicked!");
            break;
        case 1:
            NSLog(@"Ok button clicked!");
            break;
            
        default:
            break;
    }
}

#pragma mark - Switch

// Callback for switch
- (void) switchIsChanged:(UISwitch *) paramSender {
    NSLog(@"Sender is = %@", paramSender);
    if ([paramSender isOn]){
        NSLog(@"The switch is turned on.");
    }else{
        NSLog(@"The switch is turned off.");
    }
}


#pragma mark - Picker

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([self.picker isEqual:pickerView]) {
        return 1;
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.picker]) {
        return 10;
    }
    return 0;
}

// gets called for every row and sets the title for it
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    if ([pickerView isEqual:self.picker]){
        /* Row is zero-based and we want the first row (with index 0) to be rendered as Row 1, so we have to +1 every row index */
        return [NSString stringWithFormat:@"Row %ld", (long)row + 1];
    }
    
    return nil;
}

#pragma mark - Date Picker

// callback when the date is changed
- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    if ([paramDatePicker isEqual:self.datePicker]){ NSLog(@"Selected date = %@", paramDatePicker.date);
    }
}

#pragma mark - Slider

- (void) sliderValueChanged:(UISlider *)paramSender{
    if ([paramSender isEqual:self.slider]){ NSLog(@"New value = %f", paramSender.value);
    }
}


#pragma mark - Go to Second View Controller

- (void) performDisplaySecondViewController:(id)paramSender{
    SecondViewController *secondController = [[SecondViewController alloc] init];
    [self presentViewController:secondController animated:NO completion:nil];
}


@end
