//
//  RWTDetailViewController.m
//  ScaryBugs
//
//  Created by Gal Cohen on 2/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "RWTDetailViewController.h"
#import "RWTScaryBugData.h"
#import "RWTUIImageExtras.h"
#import "SVProgressHUD.h"

@interface RWTDetailViewController ()
- (void)configureView;
@end

@implementation RWTDetailViewController

@synthesize picker = _picker;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    self.rateView.notSelectedImage = [UIImage imageNamed:@"shockedface2_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"shockedface2_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"shockedface2_full.png"];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    if (self.detailItem) {
        self.titleField.text = self.detailItem.data.title;
        self.rateView.rating = self.detailItem.data.rating;
        NSLog(@"rating?? %@", self.rateView);
        self.imageView.image = self.detailItem.fullImage;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPictureTapped:(id)sender {
//    if (self.picker == nil) {
//        self.picker = [[UIImagePickerController alloc] init];
//        self.picker.delegate = self;
//        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        self.picker.allowsEditing = NO;
//    }
//    [self presentViewController:_picker animated:YES completion:nil];
    
    if (self.picker == nil) {
        
        // 1) Show status
        [SVProgressHUD showWithStatus:@"Loading picker..."];
        
        // 2) Get a concurrent queue form the system
        dispatch_queue_t concurrentQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // 3) Load picker in background
        dispatch_async(concurrentQueue, ^{
            
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.allowsEditing = NO;
            
            // 4) Present picker in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:_picker animated:YES completion:nil];
                [SVProgressHUD dismiss];
            });
            
        });
        
    }  else {
        [self presentViewController:_picker animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
//    self.detailItem.fullImage = fullImage;
//    self.detailItem.thumbImage = thumbImage;
//    self.imageView.image = fullImage;
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 1) Show status
    [SVProgressHUD showWithStatus:@"Resizing image..."];
    
    // 2) Get a concurrent queue form the system
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 3) Resize image in background
    dispatch_async(concurrentQueue, ^{
        
        UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
        
        // 4) Present image in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.detailItem.fullImage = fullImage;
            self.detailItem.thumbImage = thumbImage;
            self.imageView.image = fullImage;
            [self.detailItem saveImages];
            [SVProgressHUD dismiss];
        });
        
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)titleFieldTextChanged:(id)sender {
     self.detailItem.data.title = self.titleField.text;
    NSLog(@"this happened:%@", self.detailItem.data.title);
    [self.detailItem saveData];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
     NSLog(@"this happened:%@", self.detailItem.data.title);
    NSLog(@"this:%@", textField);
    return YES;
}

#pragma mark RWTRateViewDelegate

- (void)rateView:(RWTRateView *)rateView ratingDidChange:(float)rating {
    self.detailItem.data.rating = rating;
    NSLog(@"thisssssssssssssssssss %f", self.detailItem.data.rating);
    [self.detailItem saveData];

}

// Implement the method shouldAutorotateToInterfaceOrientation
- (BOOL)shouldAutorotateToInterfaceOrientation {
    return YES;
}
@end