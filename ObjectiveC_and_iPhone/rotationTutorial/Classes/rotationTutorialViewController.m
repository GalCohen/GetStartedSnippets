//
//  rotationTutorialViewController.m
//  rotationTutorial
//
//  Created by Gal Cohen on 8/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "rotationTutorialViewController.h"

@implementation rotationTutorialViewController

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;


-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		button1.frame = CGRectMake(20,20,125,125);
		button2.frame = CGRectMake(175,20,125,125);
		button3.frame = CGRectMake(20,168,125,125);
		button4.frame = CGRectMake(175,168,125,125);
		button5.frame = CGRectMake(20,315,125,125);
		button6.frame = CGRectMake(175,315,125,125);
	} else {
		button1.frame = CGRectMake(20,20,125,125);
		button2.frame = CGRectMake(20,155,125,125);
		button3.frame = CGRectMake(177,20,125,125);
		button4.frame = CGRectMake(177,155,125,125);
		button5.frame = CGRectMake(328,20,125,125);
		button6.frame = CGRectMake(328,155,125,125);
	}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.button1 = nil;
	self.button2 = nil;
	self.button3 = nil;
	self.button4 = nil;
	self.button5 = nil;
	self.button6 = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
	[button5 release];
	[button6 release];
	
    [super dealloc];
}

@end
