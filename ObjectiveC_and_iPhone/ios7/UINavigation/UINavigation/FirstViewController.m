//
//  FirstViewController.m
//  UINavigation
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property (nonatomic, strong) UIButton *displaySecondViewController;
@end

@implementation FirstViewController

- (void) performDisplaySecondViewController:(id)paramSender{
    SecondViewController *secondController = [[SecondViewController alloc]
                                              initWithNibName:nil
                                              bundle:NULL];
    
    [self.navigationController pushViewController:secondController
                                         animated:YES];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void) performAdd:(id)paramSender{
    NSLog(@"Action method got called.");
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"First Controller";
    self.displaySecondViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displaySecondViewController
     setTitle:@"Display Second View Controller"
     forState:UIControlStateNormal];
    [self.displaySecondViewController sizeToFit];
    self.displaySecondViewController.center = self.view.center;
    [self.displaySecondViewController
     addTarget:self action:@selector(performDisplaySecondViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displaySecondViewController];
    
    
    self.navigationItem.rightBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Add"
//                                     style:UIBarButtonItemStylePlain target:self action:@selector(performAdd:)];
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAdd:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
