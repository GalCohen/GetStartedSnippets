//
//  SMSector.m
//  RotaryWheelProject
//
//  Created by Gal Cohen on 4/22/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SMSector.h"

@implementation SMSector

- (NSString*) description {
    return [NSString stringWithFormat:@"%i | %f, %f, %f", self.sector, self.minValue, self.midValue, self.maxValue];
}

@end
