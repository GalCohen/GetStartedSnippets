//
//  MTSlider.m
//  Delegates
//
//  Created by Gal Cohen on 2/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "MTSlider.h"

@implementation MTSlider


- (id)initWithFrame:(CGRect)frame andDelegate:(id<MTSliderDelegate>)delegateObject{
    self = [super initWithFrame:frame];
    if (self) {
        self.sliderDelegate = delegateObject;
        self.value = [self.sliderDelegate startPositionForMTSlider:self];
    }
    return self;
}

- (void)setValue:(float)value animated:(BOOL)animated{
    [super setValue:value animated:animated];
    if (self.sliderDelegate != nil && [self.sliderDelegate respondsToSelector:@selector(MTSliderDidChange:withValue:)]){
        [[self sliderDelegate] MTSliderDidChange:self withValue:value];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
