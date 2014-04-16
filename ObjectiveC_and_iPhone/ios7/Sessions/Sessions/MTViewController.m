//
//  MTViewController.m
//  Sessions
//
//  Created by Gal Cohen on 4/16/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate> {
    NSURLSession *_session;
}

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (strong, nonatomic) NSData *resumeData;


- (IBAction)cancel:(id)sender;
- (IBAction)resume:(id)sender;

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@", json);
//    }];
//    [dataTask resume];
    
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession  sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"]];
//    [downloadTask resume];
    
    // Create Download Task
//    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2014/01/5a3f1-sample.jpg"]];
//    
//    // Resume Download Task
//    [self.downloadTask resume];
    
    // Add Observer
    [self addObserver:self forKeyPath:@"resumeData" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"downloadTask" options:NSKeyValueObservingOptionNew context:NULL];
    
    // Setup User Interface
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    
    // Create Download Task
    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2014/01/5a3f1-sample.jpg"]];
    
    // Resume Download Task
    [self.downloadTask resume];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURLSession *)session {
    if (!_session) {
        // Create Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // Create Session
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    
    return _session;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"resumeData"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.resumeButton setHidden:(self.resumeData == nil)];
        });
        
    } else if ([keyPath isEqualToString:@"downloadTask"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cancelButton setHidden:(self.downloadTask == nil)];
        });
    }
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    if (!self.downloadTask) return;
    
    // Hide Cancel Button
    [self.cancelButton setHidden:YES];
    
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        if (!resumeData) return;
        [self setResumeData:resumeData];
        [self setDownloadTask:nil];
    }];
}

- (IBAction)resume:(id)sender {
    if (!self.resumeData) return;
    
    // Hide Resume Button
    [self.resumeButton setHidden:YES];
    
    // Create Download Task
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    
    // Resume Download Task
    [self.downloadTask resume];
    
    // Cleanup
    [self setResumeData:nil];
}


#pragma mark - NSURLSession delegates

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:progress];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cancelButton setHidden:YES];
        [self.progressView setHidden:YES];
        [self.imageView setImage:[UIImage imageWithData:data]];
    });
    
    // Invalidate Session
    [session finishTasksAndInvalidate];
}

@end
