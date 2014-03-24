//
//  MTPhotosViewController.h
//  Secure Photos
//
//  Created by Gal Cohen on 3/24/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPhotosViewController : UICollectionViewController
@property (copy, nonatomic) NSString *username;

- (IBAction)photos:(id)sender;
@end
