//
//  SettingsViewController.m
//  TwitterApp
//
//  Created by Gal Cohen on 4/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SettingsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SettingsViewController () <UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, AVSpeechSynthesizerDelegate>


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSpeed;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedPitch;
@property (weak, nonatomic) IBOutlet UIPickerView *accentPicker;
@property (weak, nonatomic) IBOutlet UITextView *sampleTextview;

- (IBAction)speakerButtonpressed:(id)sender;
- (IBAction)segmentedPitchPressed:(id)sender;
- (IBAction)segmentedSpeedPressed:(id)sender;

@property (strong, nonatomic) NSArray *languageCodes;
@property (strong, nonatomic) NSDictionary *languageDictionary;
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

@property (strong, nonatomic) NSString *restoredTextToSpeak;

@end


@implementation SettingsViewController

NSString *UYLPrefKeySelectedSpeed = @"UYLPrefKeySelectedSpeed";
NSString *UYLPrefKeySelectedPitch = @"UYLPrefKeySelectedPitch";
NSString *UYLPrefKeySelectedLanguage = @"UYLPrefKeySelectedLanguage";
NSString *UYLKeySpeechText = @"UYLKeySpeechText";


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self restoreUserPreferences];
    self.segmentedSpeed.selectedSegmentIndex = self.selectedSpeed;
    self.segmentedPitch.selectedSegmentIndex = self.selectedPitch;
    
    NSUInteger index = [self.languageCodes indexOfObject:self.selectedLanguage];
    if (index != NSNotFound)
    {
        [self.accentPicker selectRow:index inComponent:0 animated:NO];
    }

    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.restoredTextToSpeak)
    {
        self.sampleTextview.text = self.restoredTextToSpeak;
        self.restoredTextToSpeak = nil;
    }
}


#pragma mark - Button

- (IBAction)speakerButtonpressed:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.sampleTextview.text && !self.synthesizer.isSpeaking)
    {
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.selectedLanguage];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.sampleTextview.text];
        utterance.voice = voice;
        
        float adjustedRate = AVSpeechUtteranceDefaultSpeechRate * [self rateModifier];
        if (adjustedRate > AVSpeechUtteranceMaximumSpeechRate)
        {
            adjustedRate = AVSpeechUtteranceMaximumSpeechRate;
        }
        
        if (adjustedRate < AVSpeechUtteranceMinimumSpeechRate)
        {
            adjustedRate = AVSpeechUtteranceMinimumSpeechRate;
        }
        utterance.rate = adjustedRate;
        
        float pitchMultiplier = [self pitchModifier];
        if ((pitchMultiplier >= 0.5) && (pitchMultiplier <= 2.0))
        {
            utterance.pitchMultiplier = pitchMultiplier;
        }
        NSLog(@"pitch:%f rate:%f text:%@ adjustedRate:%f ", utterance.pitchMultiplier, [self rateModifier], self.sampleTextview.text, utterance.rate);
        [self.synthesizer speakUtterance:utterance];
    }
}


#pragma mark - rates

- (float)rateModifier
{
    float rate = 1.0;
    switch (self.selectedSpeed)
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
    switch (self.selectedPitch)
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


#pragma mark - Segmented Control

- (IBAction) segmentedPitchPressed:(UISegmentedControl *)paramSender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.selectedPitch = paramSender.selectedSegmentIndex;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:self.selectedPitch forKey:UYLPrefKeySelectedPitch];
    [preferences synchronize];
}


- (IBAction) segmentedSpeedPressed:(UISegmentedControl *)paramSender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.selectedSpeed = paramSender.selectedSegmentIndex;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:self.selectedSpeed forKey:UYLPrefKeySelectedSpeed];
    [preferences synchronize];
}


#pragma mark - textview

//- (void)keyboardWasShown:(NSNotification*)notification {
//    NSDictionary* info = [notification userInfo];
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    
//    self.sampleTextview.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
//    self.sampleTextview.scrollIndicatorInsets = self.sampleTextview.contentInset;
//}
//
//
//- (void)keyboardWillBeHidden:(NSNotification*)notification {
//    self.sampleTextview.contentInset = UIEdgeInsetsZero;
//    self.sampleTextview.scrollIndicatorInsets = UIEdgeInsetsZero;
//}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.languageCodes count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *languageCode = self.languageCodes[row];
    NSString *languageName = self.languageDictionary[languageCode];
    return languageName;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedLanguage = [self.languageCodes objectAtIndex:row];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:self.selectedLanguage forKey:UYLPrefKeySelectedLanguage];
    [preferences synchronize];
}


#pragma mark - Language

- (NSDictionary *)languageDictionary
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!_languageDictionary)
    {
        NSArray *voices = [AVSpeechSynthesisVoice speechVoices];
        NSArray *languages = [voices valueForKey:@"language"];
        
        NSLocale *currentLocale = [NSLocale autoupdatingCurrentLocale];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        for (NSString *code in languages)
        {
            dictionary[code] = [currentLocale displayNameForKey:NSLocaleIdentifier value:code];
        }
        _languageDictionary = dictionary;
    }
    return _languageDictionary;
}

- (NSArray *)languageCodes
{
    if (!_languageCodes)
    {
        _languageCodes = [self.languageDictionary keysSortedByValueUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return _languageCodes;
}


#pragma mark AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.sampleTextview.text];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
    self.sampleTextview.attributedText = text;
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.sampleTextview.attributedText];
    [text removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, [text length])];
    self.sampleTextview.attributedText = text;
}


#pragma mark State Restoration

- (void)restoreUserPreferences
{
    NSString *currentLanguageCode = [AVSpeechSynthesisVoice currentLanguageCode];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaults = @{ UYLPrefKeySelectedPitch:[NSNumber numberWithInteger:UYLPitchControlNormalPitch],
                                UYLPrefKeySelectedSpeed:[NSNumber numberWithInteger:UYLSpeedControlNormalSpeed],
                                UYLPrefKeySelectedLanguage:currentLanguageCode
                                };
    [preferences registerDefaults:defaults];
    
    self.selectedPitch = [preferences integerForKey:UYLPrefKeySelectedPitch];
    self.selectedSpeed = [preferences integerForKey:UYLPrefKeySelectedSpeed];
    self.selectedLanguage = [preferences stringForKey:UYLPrefKeySelectedLanguage];
}


- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.sampleTextview.text forKey:UYLKeySpeechText];
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.restoredTextToSpeak = [coder decodeObjectForKey:UYLKeySpeechText];
    [super decodeRestorableStateWithCoder:coder];
}

@end
