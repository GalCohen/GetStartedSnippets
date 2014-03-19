//
//  SecondViewController.m
//  UIComponents
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "WebViewViewController.h"
#import "ViewController.h"
#import "StringReverserActivity.h"

@interface SecondViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *displayFirstViewController;
@property (nonatomic, strong) UIButton *displayThirdViewController;
@property (nonatomic, strong) UIButton *displayFourthViewController;
@property (nonatomic, strong) UIButton *displayWebViewViewController;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *buttonShare;
@property (nonatomic, strong) UIActivityViewController *activitViewController;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITextField *textFieldCounter;
@property (nonatomic, strong) UILabel *labelCounter;
@property (nonatomic, strong) UITextField *currentTextField;


@end

@implementation SecondViewController


#pragma mark - View Controller stuff

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"2nd ViewController";
    
    [self setupPageNavigationButtons];

    
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
    
    [self createLabel];
    [self createTextField];
    [self createButton];
    
    
    
    // Character counter in a text field
    
    CGRect textFieldFrame = CGRectMake(38.0f,
                                       160.0f,
                                       220.0f,
                                       31.0f);
    self.textFieldCounter = [[UITextField alloc]
                        initWithFrame:textFieldFrame];
    self.textFieldCounter.delegate = self;
    self.textFieldCounter.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldCounter.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textFieldCounter.textAlignment = NSTextAlignmentCenter;
    self.textFieldCounter.text = @"Sir Richard Branson";
    [self.view addSubview:self.textFieldCounter];
    CGRect labelCounterFrame = self.textFieldCounter.frame;
    labelCounterFrame.origin.y += textFieldFrame.size.height + 10;
    self.labelCounter = [[UILabel alloc] initWithFrame:labelCounterFrame];
    [self.view addSubview:self.labelCounter];
    [self calculateAndDisplayTextFieldLengthWithText:self.textFieldCounter.text];
    
    
    
    
    // Text Field with currency label
    
    CGRect textFieldFrame2 = CGRectMake(38.0f,
                                       245.0f,
                                       220.0f,
                                       31.0f);
    self.currentTextField = [[UITextField alloc]
                        initWithFrame:textFieldFrame2];
    self.currentTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:self.currentTextField];
    
    UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    currencyLabel.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    currencyLabel.font = self.currentTextField.font;
    [currencyLabel sizeToFit];
    self.currentTextField.leftView = currencyLabel;
    self.currentTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
//    if (textField == self.textField) {
//        NSLog(@"share text field");
//        [textField resignFirstResponder];
//    } else if (textField == self.textFieldCounter){
//        NSLog(@"the char chound text field");
//        
//    }
    [textField resignFirstResponder];
    return YES;
}

- (void) createLabel {
    CGRect labelFrame = CGRectMake(0.0f,
                                   0.0f,
                                   100.0f,
                                   23.0f);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.text = @"iOS 7 Programming Cookbook";
    self.label.font = [UIFont boldSystemFontOfSize:14.0f];
    self.label.center = self.view.center;
    
    self.label.backgroundColor = [UIColor clearColor];
    self.label.font = [UIFont boldSystemFontOfSize:70.0f];
    self.label.textColor = [UIColor blackColor];
    self.label.shadowColor = [UIColor lightGrayColor];
    self.label.shadowOffset = CGSizeMake(2.0f, 2.0f);
    [self.label sizeToFit];
    
    [self.view addSubview:self.label];
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


#pragma mark - Text Field Character Counter

- (void) calculateAndDisplayTextFieldLengthWithText:(NSString *)paramText{
    NSString *characterOrCharacters = @"Characters"; if ([paramText length] == 1){
        characterOrCharacters = @"Character";
    }
    self.labelCounter.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[paramText length],
                              characterOrCharacters];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
 replacementString:(NSString *)string{
    
    if ([textField isEqual:self.textFieldCounter]){
        NSString *wholeText =
        [textField.text stringByReplacingCharactersInRange:range
                                                withString:string];
        [self calculateAndDisplayTextFieldLengthWithText:wholeText];
    }
    return YES;
}



#pragma mark - Go to First View Controller

- (void) performDisplaySecondViewController:(id)paramSender{
    ViewController *firstController = [[ViewController alloc] init];
    [self presentViewController:firstController animated:NO completion:nil];
}

#pragma mark - Go to Third View Controller

- (void) performDisplayThirdViewController:(id)paramSender{
    ThirdViewController *thirdController = [[ThirdViewController alloc] init];
    [self presentViewController:thirdController animated:NO completion:nil];
}

#pragma mark - Go to Fourth View Controller

- (void) performDisplayFourthViewController:(id)paramSender{
    FourthViewController *fourthController = [[FourthViewController alloc] init];
    [self presentViewController:fourthController animated:NO completion:nil];
}

#pragma mark - Go to WebView View Controller

- (void) performDisplayWebViewViewController:(id)paramSender{
    WebViewViewController *webviewcontroller = [[WebViewViewController alloc] init];
    [self presentViewController:webviewcontroller animated:NO completion:nil];
}

#pragma mark - Silly Page navigation


- (void) setupPageNavigationButtons {
    
    // GO to first controoler button
    self.displayFirstViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displayFirstViewController setFrame:CGRectMake(10, 400, 0, 0)];
    
    [self.displayFirstViewController setTitle:@"Display First View Controller"
                                      forState:UIControlStateNormal];
    
    [self.displayFirstViewController sizeToFit];
    
    [self.displayFirstViewController addTarget:self
                                         action:@selector(performDisplaySecondViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayFirstViewController];
    
    
    // go to third controller button
    self.displayThirdViewController = [UIButton
                                       buttonWithType:UIButtonTypeSystem];
    [self.displayThirdViewController setFrame:CGRectMake(10, 425, 0, 0)];
    
    [self.displayThirdViewController setTitle:@"Display TextView View Controller"
                                     forState:UIControlStateNormal];
    
    [self.displayThirdViewController sizeToFit];
    
    [self.displayThirdViewController addTarget:self
                                        action:@selector(performDisplayThirdViewController:)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayThirdViewController];
    
    
    // go to fourth controller button
    self.displayFourthViewController = [UIButton
                                       buttonWithType:UIButtonTypeSystem];
    [self.displayFourthViewController setFrame:CGRectMake(10, 450, 0, 0)];
    
    [self.displayFourthViewController setTitle:@"Display ImageView View Controller"
                                     forState:UIControlStateNormal];
    
    [self.displayFourthViewController sizeToFit];
    
    [self.displayFourthViewController addTarget:self
                                        action:@selector(performDisplayFourthViewController:)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayFourthViewController];
    
    
    // go to webview controller button
    self.displayWebViewViewController = [UIButton
                                        buttonWithType:UIButtonTypeSystem];
    [self.displayWebViewViewController setFrame:CGRectMake(10, 475, 0, 0)];
    
    [self.displayWebViewViewController setTitle:@"Display WebView View Controller"
                                      forState:UIControlStateNormal];
    
    [self.displayWebViewViewController sizeToFit];
    
    [self.displayWebViewViewController addTarget:self
                                         action:@selector(performDisplayWebViewViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.displayWebViewViewController];
    
}

@end