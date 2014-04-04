//
//  AudioSynthesizer.m
//  TwitterApp
//
//  Created by Gal Cohen on 4/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "AudioSynthesizer.h"

@interface AudioSynthesizer ()

@end

@implementation AudioSynthesizer

static AudioSynthesizer *sharedSingleton;

+ (id)sharedManager {
    static AudioSynthesizer *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       self.UYLPrefKeySelectedSpeed = @"UYLPrefKeySelectedSpeed";
       self.UYLPrefKeySelectedPitch = @"UYLPrefKeySelectedPitch";
       self.UYLPrefKeySelectedLanguage = @"UYLPrefKeySelectedLanguage";
       self.UYLKeySpeechText = @"UYLKeySpeechText";
        
        if (!self.selectedPitch) {
            self.selectedPitch = UYLPitchControlNormalPitch;
        }
        
        if (!self.selectedSpeed) {
            self.selectedSpeed = UYLSpeedControlNormalSpeed;
        }
        
        if (!self.selectedLanguage) {
            self.selectedLanguage = [AVSpeechSynthesisVoice currentLanguageCode];
        }
        
    }
    return self;
}

- (AVSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer)
    {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}



#pragma mark - rates

- (float)rateModifier
{
    float rate = 1.0;
    //    switch (self.selectedSpeed)
    switch ([[AudioSynthesizer sharedManager] selectedSpeed])
    {
        case UYLSpeedControlQuarterSpeed:
            rate = 0.25;
            break;
        case UYLSpeedControlHalfSpeed:
            rate = 0.5;
            break;
        case UYLSpeedControlNormalSpeed:
            rate = 1.0;
            break;
        case UYLSpeedControlDoubleSpeed:
            rate = 2.0;
            break;
        default:
            rate = 1.0;
            break;
    }
    return rate;
}


- (float)pitchModifier
{
    float pitch = 1.0;
    //    switch (self.selectedPitch)
    switch ([[AudioSynthesizer sharedManager] selectedPitch])
    {
        case UYLPitchControlDeepPitch:
            pitch = 0.75;
            break;
        case UYLPitchControlNormalPitch:
            pitch = 1.0;
            break;
        case UYLPitchControlHighPitch:
            pitch = 1.5;
            break;
        default:
            pitch = 1.0;
            break;
    }
    return pitch;
}


- (void)restoreUserPreferences
{
    NSString *currentLanguageCode = [AVSpeechSynthesisVoice currentLanguageCode];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaults = @{ self.UYLPrefKeySelectedPitch:[NSNumber numberWithInteger:UYLPitchControlNormalPitch],
                                self.UYLPrefKeySelectedSpeed:[NSNumber numberWithInteger:UYLSpeedControlNormalSpeed],
                                self.UYLPrefKeySelectedLanguage:currentLanguageCode
                                };
    [preferences registerDefaults:defaults];
    
    self.selectedPitch = [preferences integerForKey:self.UYLPrefKeySelectedPitch];
    self.selectedSpeed = [preferences integerForKey:self.UYLPrefKeySelectedSpeed];
    self.selectedLanguage = [preferences stringForKey:self.UYLPrefKeySelectedLanguage];
    
}

@end
