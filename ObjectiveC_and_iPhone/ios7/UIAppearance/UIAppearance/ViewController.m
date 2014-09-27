//
//  ViewController.m
//  UIAppearance
//
//  Created by Gal Cohen on 2/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create a random color
    srand(time(NULL));
    UIColor *appearanceColor = [UIColor colorWithRed:rand()/(CGFloat)RAND_MAX green:rand()/(CGFloat)RAND_MAX blue:rand()/(CGFloat)RAND_MAX alpha:1.0];
    
    NSLog(@"Color set by appearance proxy %@", appearanceColor);
    
    // set both the navigationBar tintColor and our MyView dotColor on the class level
    [[UINavigationBar appearance] setTintColor:appearanceColor];
    [[MyView appearance] setDotColor:appearanceColor];
    
//    viewController = [ViewController];
    //    viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //    viewController = [[ViewController alloc] init];
    
    //    self.window.rootViewController = viewController;
    //    [self.window makeKeyAndVisible];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
