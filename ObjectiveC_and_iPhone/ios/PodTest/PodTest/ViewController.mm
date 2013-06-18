//
//  ViewController.m
//  PodTest
//
//  Created by Gal Cohen on 11/20/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ringBuffer = new RingBuffer(32768, 2);
    audioManager = [Novocaine audioManager];
    
    // MAKE SOME NOOOOO OIIIISSSEEE
    // ==================================================
     [audioManager setOutputBlock:^(float *newdata, UInt32 numFrames, UInt32 thisNumChannels)
         {
             for (int i = 0; i < numFrames * thisNumChannels; i++) {
                 newdata[i] = (rand() % 100) / 100.0f / 2;
         }
     }];

}

@end
