//
//  DatePicker.m
//  PickersTutorial
//
//  Created by Gal Cohen on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DatePicker.h"


@implementation DatePicker

@synthesize datePicker;


-(IBAction) pressButton{
	NSDate *choice = [datePicker date];
	NSString *words = [[NSString alloc] initWithFormat:@"This is %@", choice];
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"The title" 
						  message:words
						  delegate:nil
						  cancelButtonTitle:@"close" 
						  otherButtonTitles:nil];
	
	
	[alert show];
	[alert release];
	[words release];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    self.datePicker = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[datePicker release];
    [super dealloc];
}


@end
