//
//  SecondViewController.m
//  UINavigation
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) UIButton *displayThirdViewController;
@end

@implementation SecondViewController


- (void) switchIsChanged:(UISwitch *)paramSender{
    if ([paramSender isOn]){
        NSLog(@"Switch is on.");
    }else{
        NSLog(@"Switch is off.");
    }
}

- (void) performDisplaythirdViewController:(id)paramSender{
    ThirdViewController *thirdController = [[ThirdViewController alloc]
                                              initWithNibName:nil
                                              bundle:NULL];
    
    [self.navigationController pushViewController:thirdController
                                         animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Second Controller";
    
    self.displayThirdViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displayThirdViewController setTitle:@"Display Third View Controller"
                                     forState:UIControlStateNormal];
    [self.displayThirdViewController sizeToFit];
    self.displayThirdViewController.center = self.view.center;
    [self.displayThirdViewController addTarget:self
                                          action:@selector(performDisplaythirdViewController:)
                                forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.displayThirdViewController];

    
    UISwitch *simpleSwitch = [[UISwitch alloc] init];
    simpleSwitch.on = YES;
    [simpleSwitch addTarget:self
                     action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:simpleSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) goBack{
//    [self.navigationController popViewControllerAnimated:YES];
    
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */
    NSMutableArray *newControllers = [NSMutableArray
                                      arrayWithArray:currentControllers];
    /* Remove the last object from the array */
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}

- (void) viewDidAppear:(BOOL)paramAnimated{
    [super viewDidAppear:paramAnimated];
    [self performSelector:@selector(goBack)
               withObject:nil
               afterDelay:5.0f];
}



@end
