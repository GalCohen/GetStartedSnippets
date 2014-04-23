//
//  SMRotaryProtocol.h
//  RotaryWheelProject
//
//  Created by Gal Cohen on 4/22/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMRotaryProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;

@end