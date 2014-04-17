//
//  MTViewController.m
//  Singlecast
//
//  Created by Gal Cohen on 4/16/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "MTViewController.h"
#import "MTEpisodeCell.h"
#import "MTAppDelegate.h"
#import <MWFeedParser.h>
#import <SVProgressHUD.h>

@interface MTViewController () <MWFeedParserDelegate, UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate, NSURLSessionDownloadDelegate >
@property (strong, nonatomic) NSDictionary *podcast;
@property (strong, nonatomic) NSMutableArray *episodes;
@property (strong, nonatomic) MWFeedParser *feedParser;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSMutableDictionary *progressBuffer;
@end

static NSString *EpisodeCell = @"EpisodeCell";

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup View
    [self setupView];
    
    // Initialize Session
    [self setSession:[self backgroundSession]];
    
    // Initialize Progress Buffer
    [self setProgressBuffer:[NSMutableDictionary dictionary]];
    
    // Load Podcast
    [self loadPodcast];
    
    // Add Observer
    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"MTPodcast" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPodcast {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.podcast = [ud objectForKey:@"MTPodcast"];
}

- (void)setPodcast:(NSDictionary *)podcast {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_podcast != podcast) {
        _podcast = podcast;
        
        // Update View
        [self updateView];
        
        // Fetch and Parse Feed
        [self fetchAndParseFeed];
    }
}

- (void)fetchAndParseFeed {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!self.podcast) return;
    
    NSURL *url = [NSURL URLWithString:[self.podcast objectForKey:@"feedUrl"]];
    if (!url) return;
    
    if (self.feedParser) {
        [self.feedParser stopParsing];
        [self.feedParser setDelegate:nil];
        [self setFeedParser:nil];
    }
    
    // Clear Episodes
    if (self.episodes) {
        [self setEpisodes:nil];
    }
    
    // Initialize Feed Parser
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
    
    // Configure Feed Parser
    [self.feedParser setFeedParseType:ParseTypeFull];
    [self.feedParser setDelegate:self];
    
    // Show Progress HUD
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    // Start Parsing
    [self.feedParser parse];
}


- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // Dismiss Progress HUD
    [SVProgressHUD dismiss];
    
    // Update View
    [self.tableView reloadData];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    if (!self.episodes) {
        self.episodes = [NSMutableArray array];
    }
    
    [self.episodes addObject:item];
    
    // Update Progress Buffer
    NSURL *URL = [self urlForFeedItem:item];
    NSURL *localURL = [self URLForEpisodeWithName:[URL lastPathComponent]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[localURL path]]) {
        [self.progressBuffer setObject:@(1.0) forKey:[URL absoluteString]];
    }
}

- (void)updateView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // Update View
    self.title = [self.podcast objectForKey:@"collectionName"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if ([keyPath isEqualToString:@"MTPodcast"]) {
        self.podcast = [object objectForKey:@"MTPodcast"];
    }
}

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"MTPodcast"];
}


- (void)setupView {
    // Setup Table View
    [self setupTableView];
}

- (void)setupTableView {
    // Register Class for Cell Reuse
    [self.tableView registerClass:[MTEpisodeCell class] forCellReuseIdentifier:EpisodeCell];
}

- (NSURLSession *)backgroundSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.mobiletuts.Singlecast.BackgroundSession"];
        
        // Initialize Session
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    });
    
    return session;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.episodes ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.episodes ? self.episodes.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTEpisodeCell *cell = (MTEpisodeCell *)[tableView dequeueReusableCellWithIdentifier:EpisodeCell forIndexPath:indexPath];
    
    // Fetch Feed Item
    MWFeedItem *feedItem = [self.episodes objectAtIndex:indexPath.row];
    NSURL *URL = [self urlForFeedItem:feedItem];
    
    // Configure Table View Cell
    [cell.textLabel setText:feedItem.title];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", feedItem.date]];
    
    NSNumber *progress = [self.progressBuffer objectForKey:[URL absoluteString]];
    if (!progress) progress = @(0.0);
    
    [cell setProgress:[progress floatValue]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Fetch Feed Item
    MWFeedItem *feedItem = [self.episodes objectAtIndex:indexPath.row];
    
    // URL for Feed Item
    NSURL *URL = [self urlForFeedItem:feedItem];
    
    if (![self.progressBuffer objectForKey:[URL absoluteString]]) {
        // Download Episode with Feed Item
        [self downloadEpisodeWithFeedItem:feedItem];
    }
}


- (void)downloadEpisodeWithFeedItem:(MWFeedItem *)feedItem {
    // Extract URL for Feed Item
    NSURL *URL = [self urlForFeedItem:feedItem];
    
    if (URL) {
        // Schedule Download Task
        [[self.session downloadTaskWithURL:URL] resume];
        
        // Update Progress Buffer
        [self.progressBuffer setObject:@(0.0) forKey:[URL absoluteString]];
    }
}

- (NSURL *)urlForFeedItem:(MWFeedItem *)feedItem {
    NSURL *result = nil;
    
    // Extract Enclosures
    NSArray *enclosures = [feedItem enclosures];
    if (!enclosures || !enclosures.count) return result;
    
    NSDictionary *enclosure = [enclosures objectAtIndex:0];
    NSString *urlString = [enclosure objectForKey:@"url"];
    result = [NSURL URLWithString:urlString];
    
    return result;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // Calculate Progress
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    // Update Progress Buffer
    NSURL *URL = [[downloadTask originalRequest] URL];
    [self.progressBuffer setObject:@(progress) forKey:[URL absoluteString]];
    
    // Update Table View Cell
    MTEpisodeCell *cell = [self cellForForDownloadTask:downloadTask];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell setProgress:progress];
    });
}


- (MTEpisodeCell *)cellForForDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    // Helpers
    MTEpisodeCell *cell = nil;
    NSURL *URL = [[downloadTask originalRequest] URL];
    
    for (MWFeedItem *feedItem in self.episodes) {
        NSURL *feedItemURL = [self urlForFeedItem:feedItem];
        
        if ([URL isEqual:feedItemURL]) {
            NSUInteger index = [self.episodes indexOfObject:feedItem];
            cell = (MTEpisodeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            break;
        }
    }
    
    return cell;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // Write File to Disk
    [self moveFileWithURL:location downloadTask:downloadTask];
    
    // Update Progress Buffer
    NSURL *URL = [[downloadTask originalRequest] URL];
    [self.progressBuffer setObject:@(1.0) forKey:[URL absoluteString]];
    
    // Invoke Background Completion Handler
    [self invokeBackgroundSessionCompletionHandler];
}

- (void)moveFileWithURL:(NSURL *)URL downloadTask:(NSURLSessionDownloadTask *)downloadTask {
    // Filename
    NSString *fileName = [[[downloadTask originalRequest] URL] lastPathComponent];
    
    // Local URL
    NSURL *localURL = [self URLForEpisodeWithName:fileName];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:[URL path]]) {
        NSError *error = nil;
        [fm moveItemAtURL:URL toURL:localURL error:&error];
        
        if (error) {
            NSLog(@"Unable to move temporary file to destination. %@, %@", error, error.userInfo);
        }
    }
}

- (NSURL *)URLForEpisodeWithName:(NSString *)name {
    if (!name) return nil;
    return [self.episodesDirectory URLByAppendingPathComponent:name];
}


- (NSURL *)episodesDirectory {
    NSURL *documents = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *episodes = [documents URLByAppendingPathComponent:@"Episodes"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:[episodes path]]) {
        NSError *error = nil;
        [fm createDirectoryAtURL:episodes withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"Unable to create episodes directory. %@, %@", error, error.userInfo);
        }
    }
    
    return episodes;
}


- (void)invokeBackgroundSessionCompletionHandler {
    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        NSUInteger count = [dataTasks count] + [uploadTasks count] + [downloadTasks count];
        
        if (!count) {
            MTAppDelegate *applicationDelegate = (MTAppDelegate *)[[UIApplication sharedApplication] delegate];
            void (^backgroundSessionCompletionHandler)() = [applicationDelegate backgroundSessionCompletionHandler];
            
            if (backgroundSessionCompletionHandler) {
                [applicationDelegate setBackgroundSessionCompletionHandler:nil];
                backgroundSessionCompletionHandler();
            }
        }
    }];
}


@end
