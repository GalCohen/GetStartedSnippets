//
//  TestAppDelegate.m
//  Test
//
//  Created by Adeem Basraa on 8/5/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TestAppDelegate.h"
#import "FirstViewController.h"

@implementation TestAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	//for(int i =0; i < [listOfViews count]; i++){
	//FirstViewController *controller = [listOfViews objectAtIndex:0];
//	[controller showSplash];
//		//navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	//}
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];

	FirstViewController *controller = [[tabBarController viewControllers] objectAtIndex:0];
	[controller showSplash];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

