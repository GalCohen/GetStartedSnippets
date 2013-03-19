//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by Gal Cohen on 9/11/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController <UITextFieldDelegate>
@property (copy, nonatomic) NSString *userName;

@end
