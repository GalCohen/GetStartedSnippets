//
//  MTSlider.h
//  Delegates
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTSlider;

@protocol MTSliderDelegate <NSObject>

@optional
- (void)MTSliderDidChange:(MTSlider *)MTSlider withValue:(CGFloat)value;

@required
- (CGFloat)startPositionForMTSlider:(MTSlider *)MTSlider;

@end


@interface MTSlider : UISlider

@property (nonatomic, weak) id <MTSliderDelegate> sliderDelegate;

- (id)initWithFrame:(CGRect)frame andDelegate:(id<MTSliderDelegate>)delegateObject;

@end
