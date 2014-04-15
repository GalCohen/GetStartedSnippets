//
//  ViewController.m
//  DrawWithFire
//
//  Created by Gal Cohen on 4/15/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [fireView setEmitterPositionFromTouch: [touches anyObject]];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [fireView setEmitterPositionFromTouch: [touches anyObject]];
    [fireView setIsEmitting:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [fireView setIsEmitting:NO];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [fireView setIsEmitting:NO];
}


@end
