//
//  CEViewController.m
//  CERangeSlider
//
//  Created by Gal Cohen on 3/5/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "CEViewController.h"
#import "CERangeSlider.h"

@interface CEViewController ()

@end

@implementation CEViewController {
    CERangeSlider* _rangeSlider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    _rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
    [_rangeSlider addTarget:self
                     action:@selector(slideValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    [self performSelector:@selector(updateState) withObject:nil afterDelay:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)slideValueChanged:(id)control
{
    NSLog(@"Slider value changed: (%.2f,%.2f)",
          _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

- (void)updateState
{
    _rangeSlider.trackHighlightColour = [UIColor redColor];
    _rangeSlider.curvaceousness = 0.0;
}

@end
