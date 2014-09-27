//
//  ListViewController.h
//  ClassicPhotos
//
//  Created by Soheil M. Azarpour on 8/11/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//


// 1
#import <UIKit/UIKit.h>
// #import <CoreImage/CoreImage.h> ... you don't need CoreImage here anymore.
#import "PhotoRecord.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"
// 2
#import "AFNetworking/AFNetworking.h"

#define kDatasourceURLString @"https://sites.google.com/site/soheilsstudio/tutorials/nsoperationsampleproject/ClassicPhotosDictionary.plist"

// 3
@interface ListViewController : UITableViewController <ImageDownloaderDelegate, ImageFiltrationDelegate, UIScrollViewDelegate>

// 4
@property (nonatomic, strong) NSMutableArray *photos; // main data source of controller

// 5
@property (nonatomic, strong) PendingOperations *pendingOperations;
@end