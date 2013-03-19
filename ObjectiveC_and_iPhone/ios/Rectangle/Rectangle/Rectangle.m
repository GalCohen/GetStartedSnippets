//
//  Rectangle.m
//  Rectangle
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle

@synthesize width, height; //setters and getters
@synthesize origin;

-(int) area{
    return width*height;
}


-(int) perimeter{
    return (width+ height)*2;
}

- (void) setWH:(int)w :(int)h {
    width = w;
    height = h;
}

- (XYPoint *) origin: (XYPoint *) pt{
    return origin;
}

/*
-(void) setOrigin: (XYPoint *) pt {
    origin = pt;
}
*/
@end
