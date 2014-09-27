//
//  ThirdViewController.m
//  UINavigation
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void) segmentedControlTapped:(UISegmentedControl *)paramSender{
    switch (paramSender.selectedSegmentIndex){ case 0:{
        NSLog(@"Up");
        break; }
        case 1:{ NSLog(@"Down");
            break; }
    }
}

- (void)viewDidLoad{ [super viewDidLoad];
    self.title = @"First Controller";
    NSArray *items = @[
                       @"Up",
                       @"Down"
                       ];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]
                                            initWithItems:items];
    segmentedControl.momentary = YES;
    [segmentedControl addTarget:self action:@selector(segmentedControlTapped:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
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
