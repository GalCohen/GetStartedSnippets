//
//  AnimationCurvePicker.h
//  UIAnimationSamples
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationCurvePicker : UIView
@property (nonatomic,weak) IBOutlet UITableView *animationlist;

+ (id) newAnimationCurvePicker:(id)pickDelegate;
@end
