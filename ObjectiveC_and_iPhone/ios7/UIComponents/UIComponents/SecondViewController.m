//
//  SecondViewController.m
//  UIComponents
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "StringReverserActivity.h"

@interface SecondViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *displayFirstViewController;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *buttonShare;
@property (nonatomic, strong) UIActivityViewController *activitViewController;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"2nd ViewController";
    self.displayFirstViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displayFirstViewController setFrame:CGRectMake(10, 500, 0, 0)];
    
    [self.displayFirstViewController setTitle:@"Display First View Controller"
                                      forState:UIControlStateNormal];
    
    [self.displayFirstViewController sizeToFit];
    
    [self.displayFirstViewController addTarget:self
                                         action:@selector(performDisplaySecondViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayFirstViewController];
    
    
    // Segmented Control
    
    NSArray *segments = @[@"iPhone", @"iPad", @"iPod", @"iMac"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    // setting the x and y coordinates
    self.segmentedControl.frame = ({
        CGRect frame = self.segmentedControl.frame;
        frame.origin.x = 20.0f;
        frame.origin.y = 30.0f;
        frame;
    });
    [self.view addSubview:self.segmentedControl];
    
    //NO leaves the buttons pushed after they are tapped
     self.segmentedControl.momentary = NO;
    
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:)
                      forControlEvents:UIControlEventValueChanged];
    
    [self createTextField];
    [self createButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray *itemsToShare = @[
                              @"Item 1",
                              @"Item 2",
                              @"Item 3"
                              ];
    
    UIActivityViewController * activity = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:@[[StringReverserActivity new]]];
    
    [self presentViewController:activity animated:YES completion:nil];
}

#pragma mark - Go to First View Controller

- (void) performDisplaySecondViewController:(id)paramSender{
    ViewController *firstController = [[ViewController alloc] init];
    [self presentViewController:firstController animated:NO completion:nil];
}

#pragma mark - Segmented Control

- (void) segmentChanged:(UISegmentedControl *)paramSender{
    if ([paramSender isEqual:self.segmentedControl]){
        NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText =
        [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        NSLog(@"Segment %ld with %@ text is selected", (long)selectedSegmentIndex, selectedSegmentText);
    }
}


#pragma mark - Sharing Options with UIActivityViewController

- (void) createTextField {
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 70.0f, 280.0f, 30.0f)];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"Enter text here...";
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}

- (void) createButton {
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonShare.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttonShare.frame = CGRectMake(20.0f, 90.0f, 280.0f, 44.0f);
    [self.buttonShare setTitle:@"Share" forState:UIControlStateNormal];
    
    [self.buttonShare addTarget:self
                         action:@selector(handleShare:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonShare];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{ [textField resignFirstResponder];
    return YES;
}

- (void) handleShare:(id)paramSender{
    if ([self.textField.text length] == 0){
        NSString *message = @"Please enter a text and then press Share";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        return;
    }
    
    self.activitViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.textField.text] applicationActivities:nil];
    [self presentViewController:self.activitViewController animated:YES completion:^{}];
    
}
                

@end