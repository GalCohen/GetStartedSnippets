//
//  ViewController.m
//  BasicInteraction
//
//  Created by Gal Cohen on 10/5/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize myTextField;
@synthesize myLabel;

- (IBAction)changeLabel:(id)sender{
    NSLog(@"Hello world");
    NSString* message = [[NSString alloc] initWithFormat: @"hello %@", [myTextField text]];
    [myLabel setText:message];
    [myTextField resignFirstResponder];
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [myTextField resignFirstResponder];
    return YES;
}

- (IBAction)dissmissKeyboard:(id)sender{
    [myTextField resignFirstResponder];
}

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

@end
