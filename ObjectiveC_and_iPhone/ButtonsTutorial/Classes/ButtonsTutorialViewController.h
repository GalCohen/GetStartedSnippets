
#import <UIKit/UIKit.h>

@interface ButtonsTutorialViewController : UIViewController {
	UILabel *labelsText;
}

@property(nonatomic, retain) IBOutlet UILabel *labelsText;
-(IBAction) clicked:(id)sender;
@end

