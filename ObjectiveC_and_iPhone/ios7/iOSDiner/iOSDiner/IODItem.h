//
//  IODItem.h
//  iOSDiner
//
//  Created by Gal Cohen on 2/10/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IODItem : NSObject <NSCopying>

@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) float price;
@property (nonatomic,strong) NSString* pictureFile;

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile;

+ (NSArray*)retrieveInventoryItems;

@end
