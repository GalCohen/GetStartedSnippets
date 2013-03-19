//
//  LoginTutorialViewController.m
//  LoginTutorial
//
//  Created by Gal Cohen on 8/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "LoginTutorialViewController.h"

@implementation LoginTutorialViewController
@synthesize name;
@synthesize password;
@synthesize sLabel;


-(IBAction) sliding: (id) sender{
	UISlider *s = (UISlider *) sender;
	int value = (int) s.value;
	NSString *newLabel = [[NSString alloc] initWithFormat:@"%i", value];
	sLabel.text = newLabel;
	[newLabel release];
}

-(IBAction) goAwayKeyboard: (id) sender{
	[sender resignFirstResponder];
}
-(IBAction) tapBackground: (id) sender{
	[name resignFirstResponder];
	[password resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[name release];
	[password release];
	[sLabel release];
}

@end
