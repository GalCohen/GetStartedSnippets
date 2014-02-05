//
//  ViewController.h
//  Tap Me
//
//  Created by Gal Cohen on 2/4/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>  {
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;
}

- (IBAction)buttonPressed;

@end
