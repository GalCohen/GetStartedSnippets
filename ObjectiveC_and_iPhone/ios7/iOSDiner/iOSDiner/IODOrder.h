//
//  IODOrder.h
//  iOSDiner
//
//  Created by Gal Cohen on 2/10/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IODItem.h"

@class IODItem;

@interface IODOrder : NSObject

@property (nonatomic,strong) NSMutableDictionary* orderItems;

- (IODItem*)findKeyForOrderItem:(IODItem*)searchItem;
- (NSMutableDictionary *)orderItems;
- (NSString*)orderDescription;
- (void)addItemToOrder:(IODItem*)inItem;
- (void)removeItemFromOrder:(IODItem*)inItem;

- (float)totalOrder;

@end
