//
//  CERangeSliderKnobLayer.h
//  CERangeSlider
//
//  Created by Gal Cohen on 3/5/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class CERangeSlider;

@interface CERangeSliderKnobLayer : CALayer

@property BOOL highlighted;
@property (weak) CERangeSlider* slider;

@end
