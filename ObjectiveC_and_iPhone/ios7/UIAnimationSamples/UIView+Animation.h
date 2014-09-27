//
//  UIView+Animation.h
//  UIAnimationSamples
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;

- (void) downUnder:(float)secs option:(UIViewAnimationOptions)option;

- (void) addSubviewWithZoomInAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option;

- (void) removeWithZoomOutAnimation:(float)secs option:(UIViewAnimationOptions)option;

- (void) addSubviewWithFadeAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option;
- (void) removeWithSinkAnimation:(int)steps;
- (void) removeWithSinkAnimationRotateTimer:(NSTimer*) timer;

@end
