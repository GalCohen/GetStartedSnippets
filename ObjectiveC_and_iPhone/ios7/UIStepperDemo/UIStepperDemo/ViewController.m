//
//  ViewController.m
//  UIStepperDemo
//
//  Created by Gal Cohen on 3/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UIStepper *stepper;
- (IBAction)stepperValueChanged:(UIStepper *)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.stepper.wraps = YES; self.stepper.autorepeat = YES;
    NSUInteger value = self.stepper.value; self.valueLabel.text = [NSString stringWithFormat:@"%02d", value];
    
    self.stepper.maximumValue = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    NSUInteger value = sender.value;
    self.valueLabel.text = [NSString stringWithFormat:@"%02d", value];
}

@end
