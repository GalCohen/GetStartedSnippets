//
//  BlurView.m
//  Video Blurring
//
//  Created by Gal Cohen on 4/14/14.
//  Copyright (c) 2014 Mike Jaoudi. All rights reserved.
//

#import "BlurView.h"

@implementation BlurView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect deviceSize = [UIScreen mainScreen].bounds;
        self.layer.contentsRect = CGRectMake(frame.origin.x/deviceSize.size.height,
                                             frame.origin.y/deviceSize.size.width,
                                             frame.size.width/deviceSize.size.height,
                                             frame.size.height/deviceSize.size.width);
        self.fillMode = kGPUImageFillModeStretch;
    }
    return self;
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
