//
//  ViewController.h
//  CoreImageFun
//
//  Created by Gal Cohen on 3/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;

- (IBAction)amountSliderValueChanged:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (IBAction)loadPhoto:(id)sender;

@end
