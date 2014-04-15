//
//  DWFParticleView.h
//  DrawWithFire
//
//  Created by Gal Cohen on 4/15/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWFParticleView : UIView
-(void)setEmitterPositionFromTouch: (UITouch*)t;
-(void)setIsEmitting:(BOOL)isEmitting;
@end
