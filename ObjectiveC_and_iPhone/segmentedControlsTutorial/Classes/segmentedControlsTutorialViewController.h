//
//  segmentedControlsTutorialViewController.h
//  segmentedControlsTutorial
//
//  Created by Gal Cohen on 8/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface segmentedControlsTutorialViewController : UIViewController  <UIActionSheetDelegate>{
	UISwitch *leftSwitch;
	UISwitch *rightSwitch;
	UIButton *button;
}

@property (nonatomic, retain) IBOutlet UISwitch *leftSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *rightSwitch;
@property (nonatomic, retain) IBOutlet UIButton *button;

-(IBAction) mainControlSwitched: (id) sender;
-(IBAction) switchChanged: (id) sender;
-(IBAction) buttonPressed;


@end

