//
//  MTViewController.m
//  Secure Photos
//
//  Created by Gal Cohen on 3/24/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "MTViewController.h"
#import "SSKeychain.h"
#import "MTAppDelegate.h"
#import "MTPhotosViewController.h"

@interface MTViewController () <UIAlertViewDelegate>

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTAppDelegate *applicationDeleagte = (MTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [applicationDeleagte setNavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        NSString *password = [SSKeychain passwordForService:@"MyPhotos" account:self.usernameTextField.text];
        
        if (password.length > 0) {
            if ([self.passwordTextField.text isEqualToString:password]) {
                [self performSegueWithIdentifier:@"photosViewController" sender:nil];
                
            } else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error Login" message:@"Invalid username/password combination." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Account" message:@"Do you want to create an account?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alertView show];
        }
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Input" message:@"Username and/or password cannot be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self createAccount];
            break;
        default:
            break;
    }
}


- (void)createAccount {
    BOOL result = [SSKeychain setPassword:self.passwordTextField.text forService:@"MyPhotos" account:self.usernameTextField.text];
    
    if (result) {
        [self performSegueWithIdentifier:@"photosViewController" sender:nil];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MTPhotosViewController *photosViewController = segue.destinationViewController;
    photosViewController.username = self.usernameTextField.text;
    self.passwordTextField.text = nil;
    NSLog(@"%@", photosViewController.username);
}

@end
