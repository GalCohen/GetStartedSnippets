//
//  VehicleList.h
//  Vehicles
//
//  Created by Gal Cohen on 2/5/14.
//  Copyright (c) 2014 Designated Nerd Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleList : NSObject

//The list of vehicles.
@property (nonatomic, strong) NSArray *vehicles;

//Singleton Instance
+ (VehicleList *)sharedInstance;

@end
