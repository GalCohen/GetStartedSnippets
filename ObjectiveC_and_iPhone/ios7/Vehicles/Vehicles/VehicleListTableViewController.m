//
//  MasterViewController.m
//  Vehicles
//
//  Created by Transferred on 9/8/13.
//  Copyright (c) 2013 Designated Nerd Software. All rights reserved.
//

#import "VehicleListTableViewController.h"

#import "VehicleDetailViewController.h"
#import "Vehicle.h"
//#import "Car.h"
//#import "Motorcycle.h"
//#import "Truck.h"
#import "VehicleList.h"

@interface VehicleListTableViewController ()
@property (nonatomic, strong) NSMutableArray *vehicles;
@end

@implementation VehicleListTableViewController

#pragma mark - View Lifecycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    // Initialize the vehicle array
//    self.vehicles = [NSMutableArray array];
//    
//    // Call the setup method
//    [self setupVehicleArray];
    
    // Set the title of the View Controller, which will display in the Navigation bar.
    self.title = @"Vehicles";
}

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

#pragma mark - Data setup
-(void)setupVehicleArray
{
//    //Create a car.
//    Car *mustang = [[Car alloc] init];
//    mustang.brandName = @"Ford";
//    mustang.modelName = @"Mustang";
//    mustang.modelYear = 1968;
//    mustang.isConvertible = YES;
//    mustang.isHatchback = NO;
//    mustang.hasSunroof = NO;
//    mustang.numberOfDoors = 2;
//    mustang.powerSource = @"gas engine";
//    
//    //Add it to the array
//    [self.vehicles addObject:mustang];
//    
//    //Create another car.
//    Car *outback = [[Car alloc] init];
//    outback.brandName = @"Subaru";
//    outback.modelName = @"Outback";
//    outback.modelYear = 1999;
//    outback.isConvertible = NO;
//    outback.isHatchback = YES;
//    outback.hasSunroof = NO;
//    outback.numberOfDoors = 5;
//    outback.powerSource = @"gas engine";
//    
//    //Add it to the array.
//    [self.vehicles addObject:outback];
//    
//    //Create another car
//    Car *prius = [[Car alloc] init];
//    prius.brandName = @"Toyota";
//    prius.modelName = @"Prius";
//    prius.modelYear = 2002;
//    prius.hasSunroof = YES;
//    prius.isConvertible = NO;
//    prius.isHatchback = YES;
//    prius.numberOfDoors = 4;
//    prius.powerSource = @"hybrid engine";
//
//    //Add it to the array.
//    [self.vehicles addObject:prius];
    
//    //Create a motorcycle
//    Motorcycle *harley = [[Motorcycle alloc] init];
//    harley.brandName = @"Harley-Davidson";
//    harley.modelName = @"Softail";
//    harley.modelYear = 1979;
//    harley.engineNoise = @"Vrrrrrrrroooooooooom!";
//
//    //Add it to the array.
//    [self.vehicles addObject:harley];
//
//    //Create another motorcycle
//    Motorcycle *kawasaki = [[Motorcycle alloc] init];
//    kawasaki.brandName = @"Kawasaki";
//    kawasaki.modelName = @"Ninja";
//    kawasaki.modelYear = 2005;
//    kawasaki.engineNoise = @"Neeeeeeeeeeeeeeeeow!";
//
//    //Add it to the array
//    [self.vehicles addObject:kawasaki];

//    //Create a truck
//    Truck *silverado = [[Truck alloc] init];
//    silverado.brandName = @"Chevrolet";
//    silverado.modelName = @"Silverado";
//    silverado.modelYear = 2011;
//    silverado.numberOfWheels = 4;
//    silverado.cargoCapacityCubicFeet = 53;
//    silverado.powerSource = @"gas engine";
//
//    //Add it to the array
//    [self.vehicles addObject:silverado];
//
//    //Create another truck
//    Truck *eighteenWheeler = [[Truck alloc] init];
//    eighteenWheeler.brandName = @"Peterbilt";
//    eighteenWheeler.modelName = @"579";
//    eighteenWheeler.modelYear = 2013;
//    eighteenWheeler.numberOfWheels = 18;
//    eighteenWheeler.cargoCapacityCubicFeet = 408;
//    eighteenWheeler.powerSource = @"diesel engine";
//
//    //Add it to the array
//    [self.vehicles addObject:eighteenWheeler];
    
    
    
    
//    //Create a car.
//    Car *mustang = [Car carWithBrandName:@"Ford" modelName:@"Mustang" modelYear:1968
//                             powerSource:@"gas engine" numberOfDoors:2 convertible:YES hatchback:NO sunroof:NO];
//    
//    //Add it to the array
//    [self.vehicles addObject:mustang];
//    
//    //Create another car.
//    Car *outback = [Car carWithBrandName:@"Subaru" modelName:@"Outback" modelYear:1999
//                             powerSource:@"gas engine" numberOfDoors:5 convertible:NO hatchback:YES sunroof:NO];
//    
//    //Add it to the array.
//    [self.vehicles addObject:outback];
//    
//    //Create another car
//    Car *prius = [Car carWithBrandName:@"Toyota" modelName:@"Prius" modelYear:2007
//                           powerSource:@"hybrid engine" numberOfDoors:5 convertible:YES hatchback:YES sunroof:YES];
//    
//    //Add it to the array.
//    [self.vehicles addObject:prius];
//
//    
//    //Add a motorcycle
//    Motorcycle *harley = [Motorcycle motorcycleWithBrandName:@"Harley-Davidson"
//                                                   modelName:@"Softail" modelYear:1979 engineNoise:@"Vrrrrrrrroooooooooom!"];
//    
//    //Add it to the array.
//    [self.vehicles addObject:harley];
//    
//    //Add another motorcycle
//    Motorcycle *kawasaki = [Motorcycle motorcycleWithBrandName:@"Kawasaki"
//                                                     modelName:@"Ninja" modelYear:2005 engineNoise:@"Neeeeeeeeeeeeeeeeow!"];
//    
//    //Add it to the array
//    [self.vehicles addObject:kawasaki];
//    
//
//    
//    //Create a truck
//    Truck *silverado = [Truck truckWithBrandName:@"Chevrolet" modelName:@"Silverado"
//                                       modelYear:2011 powerSource:@"gas engine" wheels:4 cargoCapacityCubicFeet:53];
//    
//    [self.vehicles addObject:silverado];
//    
//    //Create another truck
//    Truck *eighteenWheeler = [Truck truckWithBrandName:@"Peterbilt" modelName:@"579"
//                                             modelYear:2013 powerSource:@"diesel engine" wheels:18 cargoCapacityCubicFeet:408];
//    
//    [self.vehicles addObject:eighteenWheeler];
//    
//    //Sort the array by the model year
//    NSSortDescriptor *modelYear = [NSSortDescriptor sortDescriptorWithKey:@"modelYear" ascending:YES];
//    [self.vehicles sortUsingDescriptors:@[modelYear]];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.vehicles.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[VehicleList sharedInstance] vehicles].count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    Vehicle *rowVehicle = self.vehicles[indexPath.row];
//    cell.textLabel.text = [rowVehicle vehicleTitleString];
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Vehicle *vehicle = [[VehicleList sharedInstance] vehicles][indexPath.row];
    cell.textLabel.text = [vehicle vehicleTitleString];
    return cell;
}

//#pragma mark - Segue Handling
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Vehicle *selectedVehicle = self.vehicles[indexPath.row];
//        [[segue destinationViewController] setDetailVehicle:selectedVehicle];
//    }
//}

#pragma mark - Segue handling
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Vehicle *selectedVehicle = [[VehicleList sharedInstance] vehicles][indexPath.row];
        [[segue destinationViewController] setDetailVehicle:selectedVehicle];
    }
}

@end
