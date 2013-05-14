//
//  ViewController.h
//  PodTest
//
//  Created by Gal Cohen on 11/20/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Novocaine.h"
#import "RingBuffer.h"
#import "AudioFileReader.h"
#import "AudioFileWriter.h"


@interface ViewController : UIViewController{

    RingBuffer *ringBuffer;
    Novocaine *audioManager;
    AudioFileReader *fileReader;
    AudioFileWriter *fileWriter;
    
}

@end
