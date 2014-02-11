//
//  MyView.m
//  UIAppearance
//
//  Created by Gal Cohen on 2/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIColor *fillColor  = (self.dotColor != nil) ? self.dotColor : [UIColor whiteColor];
    CGContextRef ctx    = UIGraphicsGetCurrentContext();
    
    //draw outer rings (demo only i.e. not great code here!)
    [fillColor setFill];
    CGContextFillEllipseInRect(ctx, self.bounds);
    
    [[UIColor whiteColor] setFill];
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, 10.0, 10.0));
    
    [fillColor setFill];
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, 20.0, 20.0));
    
    [[UIColor whiteColor] setFill];
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, 30.0, 30.0));
    
    [fillColor setFill];
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, 40.0, 40.0));
}


@end
