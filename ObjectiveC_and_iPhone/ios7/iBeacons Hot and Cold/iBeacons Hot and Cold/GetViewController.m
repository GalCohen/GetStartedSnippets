//
//  GetViewController.m
//  iBeacons Hot and Cold
//
//  Created by Jorge Costa on 10/18/13.
//  Copyright (c) 2013 MobileTuts. All rights reserved.
//

#import "GetViewController.h"

@interface GetViewController ()

@end

@implementation GetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"F2037E44-13BF-4083-A3A6-514A17BBBA10"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.MobileTuts.iBeacons"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    self.UUID.text = beacon.proximityUUID.UUIDString;
    if (beacon.proximity == CLProximityUnknown) {
        _distanceLabel.text = @"Unknown Proximity";
        [self.view setBackgroundColor:[UIColor blackColor]];
    } else if (beacon.proximity == CLProximityImmediate) {
        _distanceLabel.text = @"Immediate";
        [self.view setBackgroundColor:[UIColor redColor]];
    } else if (beacon.proximity == CLProximityNear) {
        _distanceLabel.text = @"Near";
        [self.view setBackgroundColor:[UIColor orangeColor]];
    } else if (beacon.proximity == CLProximityFar) {
        _distanceLabel.text = @"Far";
        [self.view setBackgroundColor:[UIColor blueColor]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

@end
