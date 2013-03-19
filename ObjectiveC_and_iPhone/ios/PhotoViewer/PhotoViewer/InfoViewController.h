//
//  InfoViewController.h
//  PhotoViewer
//
//  Created by Gal Cohen on 10/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface InfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (nonatomic, strong) Photo *currentPhoto;

@end
