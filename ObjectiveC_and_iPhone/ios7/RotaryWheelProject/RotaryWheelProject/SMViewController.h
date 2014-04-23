//
//  SMViewController.h
//  RotaryWheelProject
//
//  Created by Gal Cohen on 4/22/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SMRotaryProtocol.h"

@interface SMViewController : UIViewController<SMRotaryProtocol>

@property (nonatomic, strong) UILabel *sectorLabel;

@end