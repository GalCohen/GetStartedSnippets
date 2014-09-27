//
//  FakeHUD.m
//  UIAnimationSamples
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "FakeHUD.h"

@implementation FakeHUD
// create a new view from the xib
+ (id) newFakeHUD
{
	UINib *nib = [UINib nibWithNibName:@"FakeHUD" bundle:nil];
	NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    FakeHUD *me = [nibArray objectAtIndex: 0];
	return me;
}

- (IBAction)btnStop
{
	// the following method will be defined and explained later: ignore the warning
	[self removeWithSinkAnimation:40];
}
@end
