

#import <UIKit/UIKit.h>
@class RedClass;
@class BlueClass;

@interface SwitchClass : UIViewController {
	RedClass *redClass;
	BlueClass *blueClass;
}

@property (retain, nonatomic) RedClass *redClass;
@property (retain, nonatomic) BlueClass *blueClass;

-(IBAction) switchViews: (id)sender;

@end
