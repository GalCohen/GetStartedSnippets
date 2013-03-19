//
//  DetailViewController.h
//  MasterDetailExample
//
//  Created by Gal Cohen on 10/11/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
