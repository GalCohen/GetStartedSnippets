//
//  ViewController.m
//  ArrestsPlotter
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"
#import <ASIHTTPRequest.h>
#import "MyLocation.h"
#import "MBProgressHUD.h"
#define METERS_PER_MILE 1609.344

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


- (void)viewWillAppear:(BOOL)animated {
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
}




- (IBAction)refreshTapped:(id)sender {
    
    MKCoordinateRegion mapRegion = [_mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"command" ofType:@"json"];
    NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:formatString,
                      centerLocation.latitude, centerLocation.longitude, 0.5*METERS_PER_MILE];
    
//    NSURL *url = [NSURL URLWithString:@"http://data.baltimorecity.gov/api/views/INLINE/rows.json?method=index"];
    
    NSURL *url = [NSURL URLWithString:@"https://data.baltimorecity.gov/api/views/wsfq-mvij/rows.json?method=index"];
    
    ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = _request;
    
    request.requestMethod = @"POST";
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSLog(@"Response: %@", responseString);
        [self plotCrimePositions:request.responseData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading arrest...";
    [request startAsynchronous];
}


- (void)plotCrimePositions:(NSData *)responseData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSArray *data = [root objectForKey:@"data"];
    NSLog(@"data:%@", data);
    
    for (NSArray *row in data) {
//        NSNumber * latitude = [[row objectAtIndex:22]objectAtIndex:1];
//        NSNumber * longitude = [[row objectAtIndex:22]objectAtIndex:2];
//        NSString * crimeDescription = [row objectAtIndex:18];
//        NSString * address = [row objectAtIndex:14];
        
        NSNumber *latitude = [[row objectAtIndex:17] objectAtIndex:1];
        NSNumber *longitude = [[row objectAtIndex:17] objectAtIndex:2];
        NSString *crimeDescription = [row objectAtIndex:12];
        NSString *address = [row objectAtIndex:11];
        
        if (!latitude || [latitude isEqual: [NSNull null]] || [latitude isMemberOfClass:[NSNull class]]) {
            NSLog(@"this is null");
            continue;
        }
        if (!longitude || [longitude isEqual: [NSNull null]] || [longitude isMemberOfClass:[NSNull class]]) {
            NSLog(@"this is null");
            continue;
        }
        if (!crimeDescription || [crimeDescription isEqual: [NSNull null]] || [crimeDescription isMemberOfClass:[NSNull class]]) {
            NSLog(@"this is null");
            continue;
        }
        if (!address || [address isEqual: [NSNull null]] || [address isMemberOfClass:[NSNull class]]) {
            NSLog(@"this is null");
            continue;
        }
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate] ;
        [_mapView addAnnotation:annotation];
	}
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MyLocation *location = (MyLocation*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

@end
