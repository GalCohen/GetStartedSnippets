//
//  Square.m
//  Rectangle
//
//  Created by Gal Cohen on 9/14/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "Square.h"

@implementation Square: Rectangle


-(void) setSide: (int)s{
    [self setWH:s :s];
}

-(int) side{
    return width;
}

@end
