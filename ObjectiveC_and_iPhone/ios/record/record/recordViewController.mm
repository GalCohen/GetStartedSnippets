//
//  recordViewController.m
//  record
//
//  Created by Gal Cohen on 11/8/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "recordViewController.h"

@interface recordViewController ()

@end

@implementation recordViewController
@synthesize playButton, stopButton, recordButton, sendButton, audioTestsButton;

-(IBAction) send{
    NSLog(@"SEND BUTTON");
    
    [self displayComposerSheet];
    
    
}



-(IBAction) audioTests{
    
    ringBuffer = new RingBuffer(32768, 2);
    audioManager = [Novocaine audioManager];
    
    
    // Basic playthru example
//      [audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
//           float volume = 0.5;
//           vDSP_vsmul(data, 1, &volume, data, 1, numFrames*numChannels);
//           ringBuffer->AddNewInterleavedFloatData(data, numFrames, numChannels);
//       }];
//   
//  
//     [audioManager setOutputBlock:^(float *outData, UInt32 numFrames, UInt32 numChannels) {
//           ringBuffer->FetchInterleavedData(outData, numFrames, numChannels);
//       }];
//    
//    
//    // MAKE SOME NOOOOO OIIIISSSEEE
//    // ==================================================
//         [audioManager setOutputBlock:^(float *newdata, UInt32 numFrames, UInt32 thisNumChannels)
//             {
//                 for (int i = 0; i < numFrames * thisNumChannels; i++) {
//                     newdata[i] = (rand() % 100) / 100.0f / 2;
//             }
//         }];
//    
    
    // MEASURE SOME DECIBELS!
    // ==================================================
        __block float dbVal = 0.0;
        [audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {

            vDSP_vsq(data, 1, data, 1, numFrames*numChannels);
            float meanVal = 0.0;
            vDSP_meanv(data, 1, &meanVal, numFrames*numChannels);
    
            float one = 1.0;
            vDSP_vdbcon(&meanVal, 1, &one, &meanVal, 1, 1, 0);
            dbVal = dbVal + 0.2*(meanVal - dbVal);
            printf("Decibel level: %f\n", dbVal);
            
        }];
    
    
    // SIGNAL GENERATOR!
//        __block float frequency = 40.0;
//        __block float phase = 0.0;
//        [audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//         {
//    
//           float samplingRate = audioManager.samplingRate;
//             for (int i=0; i < numFrames; ++i)
//             {
//                 for (int iChannel = 0; iChannel < numChannels; ++iChannel)
//                 {
//                     float theta = phase * M_PI * 2;
//                     data[i*numChannels + iChannel] = sin(theta);
//                 }
//                 phase += 1.0 / (samplingRate / frequency);
//                 if (phase > 1.0) phase = -1;
//             }
//         }];
    
    
    // DALEK VOICE!
    // (aka Ring Modulator)
    
//      [audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//         {
//             ringBuffer->AddNewInterleavedFloatData(data, numFrames, numChannels);
//         }];
//    
//       __block float frequency = 100.0;
//        __block float phase = 0.0;
//       [audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//         {
//             ringBuffer->FetchInterleavedData(data, numFrames, numChannels);
//    
//            float samplingRate = audioManager.samplingRate;
//             for (int i=0; i < numFrames; ++i)
//             {
//                 for (int iChannel = 0; iChannel < numChannels; ++iChannel)
//                 {
//                     float theta = phase * M_PI * 2;
//                     data[i*numChannels + iChannel] *= sin(theta);
//                 }
//                 phase += 1.0 / (samplingRate / frequency);
//                 if (phase > 1.0) phase = -1;
//             }
//         }];
    
    // VOICE-MODULATED OSCILLATOR
    
//        __block float magnitude = 0.0;
//        [audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//        {
//             vDSP_rmsqv(data, 1, &magnitude, numFrames*numChannels);
//         }];
//    
//       __block float frequency = 100.0;
//        __block float phase = 0.0;
//        [audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//         {
//    
//            printf("Magnitude: %f\n", magnitude);
//             float samplingRate = audioManager.samplingRate;
//             for (int i=0; i < numFrames; ++i)
//             {
//                 for (int iChannel = 0; iChannel < numChannels; ++iChannel)
//                 {
//                     float theta = phase * M_PI * 2;
//                     data[i*numChannels + iChannel] = magnitude*sin(theta);
//                 }
//                 phase += 1.0 / (samplingRate / (frequency));
//                 if (phase > 1.0) phase = -1;
//             }
//         }];
    
}



-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Email from the app! woohoo!"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"galcohen26@gmail.com"];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"alonchook@gmail.com", /*@"third@example.com",*/ nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
   [picker setToRecipients:toRecipients];
   [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    // UIImage *coolImage =  nil;
    //NSData *myData = UIImagePNGRepresentation(coolImage);
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];

    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    NSData *myData = [NSData dataWithContentsOfFile:soundFilePath];
    NSString *fileName = @"sound.caf";
    
    [picker addAttachmentData:myData mimeType:@"audio/m4a" fileName:fileName];
    
    //   [picker addAttachmentData:myData mimeType:@"audio/caf  " fileName:@"sound.caf"];
    
    // Fill out the email body text
    NSString *emailBody = @"My cool audio is attached";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion: nil];
    NSLog(@"made it here!!");
    
    //[picker release];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) recordAudio
{
    if (!audioRecorder.recording)
    {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        [audioRecorder record];
    }
}


-(void)stop
{
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
        
        //[self displayComposerSheet];
        
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}



-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        stopButton.enabled = YES;
        recordButton.enabled = NO;
        
        // if (audioPlayer)
        //   [audioPlayer release];
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:audioRecorder.url
                       error:&error];
        
        audioPlayer.delegate = self;
        
        // if (error)
        //  NSLog(@"Error: %@",
        //        [error localizedDescription]);
        //else
        [audioPlayer play];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    playButton.enabled = NO;
    stopButton.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary  dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:AVAudioQualityMax],AVEncoderAudioQualityKey,
                                            [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                            [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                            [NSNumber numberWithFloat:8000.0], AVSampleRateKey,nil
                                    ];
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        
    } else {
        [audioRecorder prepareToRecord];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    recordButton.enabled = YES;
    stopButton.enabled = NO;
}
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
}
-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}


@end
