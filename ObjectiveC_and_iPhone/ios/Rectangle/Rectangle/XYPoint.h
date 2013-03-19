//
//  XYPoint.h
//  Rectangle
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPoint : NSObject{
    int x;
    int y;
    
}

@property int x, y;

- (void) setXY : (int)xVal: (int)yVal;

@end
