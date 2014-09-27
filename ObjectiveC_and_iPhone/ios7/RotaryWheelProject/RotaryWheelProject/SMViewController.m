//
//  SMViewController.m
//  RotaryWheelProject
//
//  Created by Gal Cohen on 4/22/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SMViewController.h"
#import "SMRotaryWheel.h"

@interface SMViewController ()

@end

@implementation SMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
    self.sectorLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.sectorLabel];
    SMRotaryWheel *wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                                    andDelegate:self
                                                   withSections:8];
    wheel.center = CGPointMake(160, 240);
    [self.view addSubview:wheel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.sectorLabel.text = newValue;
}

@end
