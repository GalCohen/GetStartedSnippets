//
//  DIsplayViewController.m
//  PhotoViewer
//
//  Created by Gal Cohen on 10/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "DIsplayViewController.h"

@interface DIsplayViewController ()

@end

@implementation DIsplayViewController

@synthesize currentPhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
