//
//  RWRotationGestureRecognizer.h
//  KnobControl
//
//  Created by Gal Cohen on 4/10/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWRotationGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) CGFloat touchAngle;

@end
