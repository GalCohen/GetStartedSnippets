
#import "multiViewTutorial02AppDelegate.h"
#import "SwitchClass.h"

@implementation multiViewTutorial02AppDelegate

@synthesize window;
@synthesize switchClass;

#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[window addSubview:switchClass.view];
	[window makeKeyAndVisible];
	
	return YES;
}

#pragma mark -
#pragma mark Memory management


- (void)dealloc {
    [window release];
	[switchClass release];
    [super dealloc];
}


@end
