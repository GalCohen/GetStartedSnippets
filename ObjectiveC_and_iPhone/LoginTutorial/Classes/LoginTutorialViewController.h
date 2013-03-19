//
//  LoginTutorialViewController.h
//  LoginTutorial
//
//  Created by Gal Cohen on 8/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTutorialViewController : UIViewController {
	UITextField *name;
	UITextField *password;
	UILabel *sLabel;
}

@property(retain, nonatomic) IBOutlet UITextField *name;
@property(retain, nonatomic) IBOutlet UITextField *password;
@property(retain, nonatomic) IBOutlet UILabel *sLabel;

-(IBAction) sliding: (id) sender;
-(IBAction) goAwayKeyboard: (id) sender;
-(IBAction) tapBackground: (id) sender;
@end

