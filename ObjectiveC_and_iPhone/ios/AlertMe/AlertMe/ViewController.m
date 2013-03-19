//   a
//  ViewController.m
//  AlertMe
//
//  Created by Gal Cohen on 10/8/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

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


- (void) viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];
    
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"Alert title"
                            message:@"There was a problem!"
                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [myAlert show];
}

@end
