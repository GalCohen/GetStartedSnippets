#import "SinglePicker.h"


@implementation SinglePicker;

@synthesize singlePicker;
@synthesize pickerArray;

-(IBAction) pressButton{
	NSInteger row = [singlePicker selectedRowInComponent:0];
	NSString *choice = [pickerArray objectAtIndex:row];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"t" message:choice delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
	
	[alert show];
	[alert release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSArray *array = [[NSArray alloc] initWithObjects:@"tune", @"fish", @"apple", @"salmon", nil];
	
	self.pickerArray = array;
	
	[array release];
	
    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}


-(NSInteger) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return [pickerArray count];
}


-(NSString *) pickerView:(UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent: (NSInteger) component {
	return @"apples";
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.singlePicker = nil;
	self.pickerArray = nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[singlePicker release];
	[pickerArray release];
	
    [super dealloc];
}


@end
