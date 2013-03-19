//
//  Photo.h
//  PhotoViewer
//
//  Created by Gal Cohen on 10/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *notes;

@end
