//
//  AudioSynthesizer.h
//  TwitterApp
//
//  Created by Gal Cohen on 4/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioSynthesizer : NSObject <AVSpeechSynthesizerDelegate>


//@property (strong, nonatomic) NSArray *languageCodes;
//@property (strong, nonatomic) NSDictionary *languageDictionary;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

typedef NS_ENUM(NSInteger, UYLSpeedControlIndex)
{
    UYLSpeedControlQuarterSpeed = 0,
    UYLSpeedControlHalfSpeed = 1,
    UYLSpeedControlNormalSpeed = 2,
    UYLSpeedControlDoubleSpeed = 3
};

typedef NS_ENUM(NSInteger, UYLPitchControlIndex)
{
    UYLPitchControlDeepPitch = 0,
    UYLPitchControlNormalPitch = 1,
    UYLPitchControlHighPitch = 2
};

@property (assign, nonatomic) UYLSpeedControlIndex selectedSpeed;
@property (assign, nonatomic) UYLPitchControlIndex selectedPitch;
@property (strong, nonatomic) NSString *selectedLanguage;

@property (assign, nonatomic) NSString *UYLPrefKeySelectedSpeed;
@property (assign, nonatomic) NSString *UYLPrefKeySelectedPitch;
@property (assign, nonatomic) NSString *UYLPrefKeySelectedLanguage;
@property (assign, nonatomic) NSString *UYLKeySpeechText;

+ (id)sharedManager;

- (float)rateModifier;
- (float)pitchModifier;
- (void)restoreUserPreferences;

@end
