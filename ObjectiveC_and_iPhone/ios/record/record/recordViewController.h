//
//  recordViewController.h
//  record
//
//  Created by Gal Cohen on 11/8/12.
//  Copyright (c) 2 012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Novocaine.h"
#import "RingBuffer.h"
#import "AudioFileReader.h"
#import "AudioFileWriter.h"
//#import <UPnPDB.h>


@interface recordViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, MFMailComposeViewControllerDelegate>{
    
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    UIButton *playButton;
    UIButton *recordButton;
    UIButton *stopButton;
    UIButton *sendButton;
    
    RingBuffer *ringBuffer;
    Novocaine *audioManager;
    AudioFileReader *fileReader;
    AudioFileWriter *fileWriter;
    
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIButton *sendButton;
@property (nonatomic, retain) IBOutlet UIButton *audioTestsButton;

-(IBAction) recordAudio;
-(IBAction) playAudio;
-(IBAction) stop;
-(IBAction) send;
-(IBAction) audioTests;

@end

