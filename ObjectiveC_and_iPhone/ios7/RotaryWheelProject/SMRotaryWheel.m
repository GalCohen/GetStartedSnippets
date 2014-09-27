//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by Gal Cohen on 4/22/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

@import QuartzCore;
#import "SMRotaryWheel.h"

@interface SMRotaryWheel()

@end

static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation SMRotaryWheel

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        self.currentSector = 0;
        [self drawWheel];
        // 4 - Timer for rotating wheel
//        [NSTimer scheduledTimerWithTimeInterval:2.0
//                                         target:self
//                                       selector:@selector(rotate)
//                                       userInfo:nil
//                                        repeats:YES];
	}
    return self;
}

- (void) drawWheel {
    // view that we’ll put everything else inside.
    self.container = [[UIView alloc] initWithFrame:self.frame];
    
    // There are 2 * PI radians in a circle s we divide the number of
    // radians by the number of sections we wish to display in our control. This gives us an
    // amount we have to rotate between sections, which we’ll use later.
    CGFloat angleSize = 2*M_PI/self.numberOfSections;
    
    // For each section, we create a label and set the anchor point to the middle right,
    // 3 - Create the sectors
	for (int i = 0; i < self.numberOfSections; i++) {
        // 4 - Create image view
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment.png"]];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(self.container.bounds.size.width/2.0-self.container.frame.origin.x,
                                        self.container.bounds.size.height/2.0-self.container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        im.tag = i;
        if (i == 0) {
            im.alpha = maxAlphavalue;
        }
		// 5 - Set sector image
        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
        sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [im addSubview:sectorImage];
        // 6 - Add image view to container
        [self.container addSubview:im];
	}
    // Adds the container to the main control.
    self.container.userInteractionEnabled = NO;
    [self addSubview:self.container];
    
    // 7.1 - Add background image
	UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
	bg.image = [UIImage imageNamed:@"bg.png"];
	[self addSubview:bg];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    mask.image =[UIImage imageNamed:@"centerButton.png"] ;
    mask.center = self.center;
    mask.center = CGPointMake(mask.center.x, mask.center.y+3);
    [self addSubview:mask];
    
    
    // 8 - Initialize sectors
    self.sectors = [NSMutableArray arrayWithCapacity:self.numberOfSections];
    if (self.numberOfSections % 2 == 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
    
//    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]];
    [self.delegate wheelDidChangeValue:[self getSectorName:self.currentSector]];
}

- (void) buildSectorsOdd {
	// 1 - Define sector length
    CGFloat fanWidth = M_PI*2/self.numberOfSections;
	// 2 - Set initial midpoint
    CGFloat mid = 0;
	// 3 - Iterate through all sectors
    for (int i = 0; i < self.numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
		// 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if (sector.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
		// 5 - Add sector to array
        [self.sectors addObject:sector];
		NSLog(@"cl is %@", sector);
    }
}

- (void) buildSectorsEven {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/self.numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < self.numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        if (sector.maxValue-fanWidth < - M_PI) {
            mid = M_PI;
            sector.midValue = mid;
            sector.minValue = fabsf(sector.maxValue);
            
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        // 5 - Add sector to array
        [self.sectors addObject:sector];
    }
}

- (void) rotate {
    CGAffineTransform t = CGAffineTransformRotate(self.container.transform, -0.78);
    self.container.transform = t;
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}


                
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
    // 1.1 - Get the distance from the center
    float dist = [self calculateDistanceFromCenter:touchPoint];
    // 1.2 - Filter out touches too close to the center
    if (dist < 40 || dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    // 2 - Calculate distance from center
    float dx = touchPoint.x - self.container.center.x;
    float dy = touchPoint.y - self.container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx);
    // 4 - Save current transform
    self.startTransform = self.container.transform;
    // 5 - Set current sector's alpha value to the minimum value
	UIImageView *im = [self getSectorByValue:self.currentSector];
	im.alpha = minAlphavalue;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGFloat radians = atan2f(self.container.transform.b, self.container.transform.a);
    NSLog(@"rad is %f", radians);
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - self.container.center.x;
    float dy = pt.y  - self.container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    self.container.transform = CGAffineTransformRotate(self.startTransform, -angleDifference);
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(self.container.transform.b, self.container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (SMSector *s in self.sectors) {
        // 4 - Check for anomaly (occurs with even number of sectors)
        if (s.minValue > 0 && s.maxValue < 0) {
            if (s.maxValue > radians || s.minValue < radians) {
                // 5 - Find the quadrant (positive or negative)
                if (radians > 0) {
                    newVal = radians - M_PI;
                } else {
                    newVal = M_PI + radians;
                }
                self.currentSector = s.sector;
            }
        }
        // 6 - All non-anomalous cases
        else if (radians > s.minValue && radians < s.maxValue) {
            newVal = radians - s.midValue;
            self.currentSector = s.sector;
        }
    }
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(self.container.transform, -newVal);
    self.container.transform = t;
    [UIView commitAnimations];
    
    [self.delegate wheelDidChangeValue:[self getSectorName:self.currentSector]];
    
    // 10 - Highlight selected sector
	UIImageView *im = [self getSectorByValue:self.currentSector];
	im.alpha = maxAlphavalue;
    
}


- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [self.container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}

- (NSString *) getSectorName:(int)position {
    NSString *res = @"";
    switch (position) {
        case 0:
            res = @"Circles";
            break;
            
        case 1:
            res = @"Flower";
            break;
            
        case 2:
            res = @"Monster";
            break;
            
        case 3:
            res = @"Person";
            break;
            
        case 4:
            res = @"Smile";
            break;
            
        case 5:
            res = @"Sun";
            break;
            
        case 6:
            res = @"Swirl";
            break;
            
        case 7:
            res = @"3 circles";
            break;
            
        case 8:
            res = @"Triangle";
            break;
            
        default:
            break;
    }
    return res;
}

@end