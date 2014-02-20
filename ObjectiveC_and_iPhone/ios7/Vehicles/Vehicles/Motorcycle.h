//
//  Motorcycle.h
//  Vehicles
//
//  Created by Gal Cohen on 2/5/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

#import "Vehicle.h"

@interface Motorcycle : Vehicle

@property (nonatomic, strong) NSString *engineNoise;

//Factory Method
+(Motorcycle *)motorcycleWithBrandName:(NSString *)brandName modelName:(NSString *)modelName modelYear:(NSInteger)modelYear engineNoise:(NSString *)engineNoise;

@end
