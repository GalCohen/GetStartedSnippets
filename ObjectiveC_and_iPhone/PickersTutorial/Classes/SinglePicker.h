

#import <UIKit/UIKit.h>


@interface SinglePicker : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *singlePicker;
	
	NSArray *pickerArray;
}


@property (nonatomic, retain) IBOutlet UIPickerView *singlePicker;
@property (nonatomic, retain) NSArray *pickerArray;

-(IBAction) pressButton;

@end