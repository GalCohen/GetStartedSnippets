//
//  Album+TableRepresentation.h
//  BlueLibrary
//
//  Created by Gal Cohen on 3/4/14.
//  Copyright (c) 2014 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)
- (NSDictionary*)tr_tableRepresentation;
@end
