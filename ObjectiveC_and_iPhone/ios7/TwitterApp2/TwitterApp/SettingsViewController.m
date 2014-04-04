//
//  SettingsViewController.m
//  TwitterApp
//
//  Created by Gal Cohen on 4/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "SettingsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioSynthesizer.h"

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

@property (strong, nonatomic) NSString *restoredTextToSpeak;

@end


@implementation SettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AudioSynthesizer *audioSynth =  [AudioSynthesizer sharedManager];
//    [audioSynth restoreUserPreferences];
    self.segmentedSpeed.selectedSegmentIndex  = audioSynth.selectedSpeed;
    self.segmentedSpeed.selectedSegmentIndex  = audioSynth.selectedPitch;
    
    NSUInteger index = [self.languageCodes indexOfObject: audioSynth.selectedLanguage];
    if (index != NSNotFound)
    {
        [self.accentPicker selectRow:index inComponent:0 animated:YES];
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
        _synthesizer = [[AudioSynthesizer sharedManager] synthesizer];
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
        AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];

        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage: audioSynth.selectedLanguage];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.sampleTextview.text];
        utterance.voice = voice;
        
        float adjustedRate = AVSpeechUtteranceDefaultSpeechRate * [audioSynth rateModifier];
        if (adjustedRate > AVSpeechUtteranceMaximumSpeechRate)
        {
            adjustedRate = AVSpeechUtteranceMaximumSpeechRate;
        }
        
        if (adjustedRate < AVSpeechUtteranceMinimumSpeechRate)
        {
            adjustedRate = AVSpeechUtteranceMinimumSpeechRate;
        }
        utterance.rate = adjustedRate;
        
        float pitchMultiplier = [audioSynth pitchModifier];
        if ((pitchMultiplier >= 0.5) && (pitchMultiplier <= 2.0))
        {
            utterance.pitchMultiplier = pitchMultiplier;
        }
        NSLog(@"pitch:%f rate:%f text:%@ adjustedRate:%f ", utterance.pitchMultiplier, [audioSynth rateModifier], self.sampleTextview.text, utterance.rate);
        [self.synthesizer speakUtterance:utterance];
    }
}


#pragma mark - Segmented Control

- (IBAction) segmentedPitchPressed:(UISegmentedControl *)paramSender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];
    
    audioSynth.selectedPitch = paramSender.selectedSegmentIndex;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:audioSynth.selectedPitch forKey:audioSynth.UYLPrefKeySelectedPitch];
    [preferences synchronize];
}


- (IBAction) segmentedSpeedPressed:(UISegmentedControl *)paramSender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];

    audioSynth.selectedSpeed = paramSender.selectedSegmentIndex;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:audioSynth.selectedSpeed forKey:audioSynth.UYLPrefKeySelectedSpeed];
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

    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];

    audioSynth.selectedLanguage = [self.languageCodes objectAtIndex:row];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:audioSynth.selectedLanguage forKey:audioSynth.UYLPrefKeySelectedLanguage];
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

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];
    [coder encodeObject:self.sampleTextview.text forKey:audioSynth.UYLKeySpeechText];
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];
    self.restoredTextToSpeak = [coder decodeObjectForKey:audioSynth.UYLKeySpeechText];
    [super decodeRestorableStateWithCoder:coder];
}

@end
