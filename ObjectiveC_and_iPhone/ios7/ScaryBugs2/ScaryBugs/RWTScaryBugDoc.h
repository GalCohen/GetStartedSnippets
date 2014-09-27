//
//  RWTScaryBugDoc.h
//  ScaryBugs
//
//  Created by Gal Cohen on 2/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWTScaryBugData;

@interface RWTScaryBugDoc : NSObject {
      RWTScaryBugData *_data;
}

@property (strong) RWTScaryBugData *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *fullImage;
@property (copy) NSString *docPath;

- (id)init;
- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)saveImages;
- (void)deleteDoc;

@end