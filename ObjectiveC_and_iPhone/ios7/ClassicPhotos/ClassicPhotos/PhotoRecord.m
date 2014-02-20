//
//  PhotoRecord.m
//  ClassicPhotos
//
//  Created by Gal Cohen on 2/20/14.
//  Copyright (c) 2014 iOS Developer. All rights reserved.
//

#import "PhotoRecord.h"
@implementation PhotoRecord

@synthesize name = _name;
@synthesize image = _image;
@synthesize URL = _URL;
@synthesize hasImage = _hasImage;
@synthesize filtered = _filtered;
@synthesize failed = _failed;


- (BOOL)hasImage {
    return _image != nil;
}


- (BOOL)isFailed {
    return _failed;
}


- (BOOL)isFiltered {
    return _filtered;
}

@end