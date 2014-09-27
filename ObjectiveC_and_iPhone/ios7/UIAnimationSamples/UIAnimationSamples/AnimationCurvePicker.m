//
//  AnimationCurvePicker.m
//  UIAnimationSamples
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "AnimationCurvePicker.h"

@implementation AnimationCurvePicker
@synthesize animationlist;

+ (id) newAnimationCurvePicker:(id)pickerDelegate
{
    UINib *nib = [UINib nibWithNibName:@"AnimationCurvePicker" bundle:nil];
    NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    AnimationCurvePicker *me = [nibArray objectAtIndex: 0];
    me.animationlist.delegate = pickerDelegate;
    me.animationlist.dataSource = pickerDelegate;
    return me;
}

@end
