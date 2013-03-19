
#import "PickersTutorialAppDelegate.h"

@implementation PickersTutorialAppDelegate

@synthesize window;
@synthesize rootController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	[window addSubview:rootController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[rootController release];
    [window release];
    [super dealloc];
}


@end
