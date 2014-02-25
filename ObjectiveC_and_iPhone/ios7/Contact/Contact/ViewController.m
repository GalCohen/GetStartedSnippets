//
//  ViewController.m
//  Contact
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *firstName = [defaults objectForKey:@"firstName"];
    NSString *lastName = [defaults objectForKey:@"lastname"];
    
    int age = [defaults integerForKey:@"age"];
    NSString *ageString = [NSString stringWithFormat:@"%i",age];
    
    NSData *imageData = [defaults dataForKey:@"image"];
    UIImage *contactImage = [UIImage imageWithData:imageData];
    
    // Update the UI elements with the saved data
    self.firstNameTextField.text = firstName;
    self.lastNameTextField.text = lastName;
    self.ageTextField.text = ageString;
    self.contactImageView.image = contactImage;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    // Hide the keyboard
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    
    // Create strings and integer to store the text info
    NSString *firstName = [self.firstNameTextField text];
    NSString *lastName  = [self.lastNameTextField text];
    int age = [[self.ageTextField text] integerValue];
    
    // Create instances of NSData
    UIImage *contactImage = self.contactImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(contactImage, 100);
    
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:firstName forKey:@"firstName"];
    [defaults setObject:lastName forKey:@"lastname"];
    [defaults setInteger:age forKey:@"age"];
    [defaults setObject:imageData forKey:@"image"];
    
    [defaults synchronize];
    
    NSLog(@"Data saved");
}

- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init] ;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
//    [self presentedViewController:r]
    
}

#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.contactImageView.image = image;
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
