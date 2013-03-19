//
//  DIsplayViewController.h
//  PhotoViewer
//
//  Created by Gal Cohen on 10/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "Photo.h"
@interface DIsplayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *currentImage;

@property (nonatomic, strong) Photo *currentPhoto;

@end
