//
//  Rectangle.h
//  Rectangle
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYPoint;

@interface Rectangle : NSObject{
    int width;
    int height;
    XYPoint *origin;
}

@property int width, height;
@property XYPoint *origin;

-(int) area;
-(int) perimeter;
- (void) setWH: (int)w : (int)h;
- (XYPoint *) origin: (XYPoint *) pt;
-(void) setOrigin: (XYPoint *) pt;

@end
