//
//  ViewController.h
//  DataSources
//
//  Created by Gal Cohen on 10/9/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *moodList;

@end
