//
//  ViewController.m
//  PickerControl2
//
//  Created by Gal Cohen on 10/9/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayDay:(id)sender {
    NSLog(@"button push!");
    NSDate *chosen = [datePicker date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"butotn push2!");
    [formatter setDateFormat:@"EEEE"];
    
    NSString *weekday = [formatter stringFromDate:chosen];
    NSString *msg = [[NSString alloc] initWithFormat:@"That's a %@", weekday];
    
    NSLog(@"button push3!!");
    
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"what day is that?" message:msg delegate:nil cancelButtonTitle:@"thanks" otherButtonTitles: nil];
    NSLog(@"button push 4");
    [myAlert show];
}
@end
