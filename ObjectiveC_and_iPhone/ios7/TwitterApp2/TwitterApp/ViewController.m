//
//  ViewController.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/24/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"
#import "TweetList.h"
#import "TweetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "AudioSynthesizer.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AVSpeechSynthesizerDelegate>

@property TweetList* tweetList;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property BOOL readingWholeList;
@property BOOL currentlyPlaying;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.synthesizer  = [[AudioSynthesizer sharedManager] synthesizer];
    
    [self.synthesizer setDelegate:self];
    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
        NSLog(@"%@", error.description);
    }
    [session setActive:YES error:&error];
    if (error) {
        // Do some error handling
        NSLog(@"%@", error.description);
    }

    self.readingWholeList = NO;
    self.currentlyPlaying = NO;
    
    NSArray* jsonTest = @[
                          @{
                              @"coordinates" : @"null",
                              @"truncated" : @"false",
                              @"source" : @"<a href=\"https://about.twitter.com/products/tweetdeck\" rel=\"nofollow\">TweetDeck</a>",
                              @"retweet_count" : @1,
                              @"created_at" : @"Mon Mar 24 21:31:41 +0000 2014",
                              @"user" : @{
                                      @"profile_link_color" : @"CC6633",
                                      @"id" : @30322151,
                                      @"default_profile" : @"false",
                                      @"lang" : @"en",
                                      @"protected" : @"false",
                                      @"url" : @"http://www.ffvc.com",
                                      @"geo_enabled" : @"false",
                                      @"contributors_enabled" : @"false",
                                      @"profile_background_color" : @"484848",
                                      @"utc_offset" : @-14400,
                                      @"time_zone" : @"Eastern Time (US & Canada)",
                                      @"profile_image_url" : @"http://pbs.twimg.com/profile_images/378800000467094257/0f9b5f012ccde581f23f12de772afee0_normal.jpeg",
                                      @"description" : @"Early stage venture capitalist.\r\n\r\nLove working with energetic entrepreneurs working to change the world.",
                                      @"created_at" : @"Fri Apr 10 21:51:04 +0000 2009",
                                      @"follow_request_sent" : @"false",
                                      @"profile_use_background_image" : @"false",
                                      @"notifications" : @"false",
                                      @"location" : @"New York",
                                      @"name" : @"john frankel",
                                      @"profile_sidebar_border_color" : @"17458A",
                                      @"profile_background_tile" : @"false",
                                      @"profile_sidebar_fill_color" : @"EEEEEE",
                                      @"is_translation_enabled" : @"false",
                                      @"following" : @"true",
                                      @"profile_text_color" : @"356AA0",
                                      @"default_profile_image" : @"false",
                                      @"followers_count" : @13198,
                                      @"statuses_count" : @18349,
                                      @"screen_name" : @"john_frankel",
                                      @"friends_count" : @907,
                                      @"listed_count" : @579,
                                      @"id_str" : @"30322151",
                                      @"is_translator" : @"false",
                                      @"profile_background_image_url_https" : @"https://pbs.twimg.com/profile_background_images/344007694/ff_Main_Logo.jpg",
                                      @"verified" : @"true",
                                      @"profile_image_url_https" : @"https://pbs.twimg.com/profile_images/378800000467094257/0f9b5f012ccde581f23f12de772afee0_normal.jpeg",
                                      @"favourites_count" : @33,
                                      @"profile_background_image_url" : @"http://pbs.twimg.com/profile_background_images/344007694/ff_Main_Logo.jpg"
                                      },
                              @"geo" : @"null",
                              @"id" : @448210568659619840,
                              @"text" : @"G7 + Russia = G7",
                              @"place" : @"null",
                              @"in_reply_to_status_id_str" : @"null",
                              @"in_reply_to_screen_name" : @"null",
                              @"in_reply_to_user_id_str" : @"null",
                              @"contributors" : @"null",
                              @"in_reply_to_status_id" : @"null",
                              @"favorite_count" : @0,
                              @"entities" : @{
                                  @"urls" : @[
                                  
                                  ],
                                  @"user_mentions" : @[
                                  
                                  ],
                                  @"symbols" : @[
                                  
                                  ],
                                  @"hashtags" : @[
                                  
                                  ]
                              },
                              @"favorited" : @"false",
                              @"retweeted" : @"false",
                              @"lang" : @"in",
                              @"id_str" : @"448210568659619840",
                              @"in_reply_to_user_id" : @"null"
                              }
                          ];
    
    self.dataSource = jsonTest;
    [self.tweetTableView reloadData];
    [self getTimeLine];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getTimeLine
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount =
                 [arrayOfAccounts lastObject];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/home_timeline.json"];
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"20" forKey:@"count"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler: ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     
                      self.dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                     
                     NSError* err;
                     NSData* data = [NSJSONSerialization dataWithJSONObject:self.dataSource options:NSJSONWritingPrettyPrinted error:&err];
                     
                     self.tweetList = [[TweetList alloc] initWithJSON:data];
                     [self.tweetList printTweets];
                     
                      if (self.dataSource.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              NSLog(@"reloading table...");
                              [self.tweetTableView reloadData];
                          });
                      }
                  }];
             }
         } else {
             // Handle failure to get account access
             NSLog(@"ERROR ACCESSING ACCNT");
         }
     }];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    TweetTableViewCell *cell = [self.tweetTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TweetTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = self.dataSource[[indexPath row]];
    
    cell.contentLabel.text = tweet[@"text"];
    cell.nameLabel.text = tweet[@"user"][@"name"];
    cell.screenNameLabel.text =  [NSString stringWithFormat:@"@%@", tweet[@"user"][@"screen_name"]];
    
    cell.contentLabel.frame = CGRectMake(20,75,285,600);
    [cell.contentLabel sizeToFit];
    
    NSString *ImageURL = tweet[@"user"][@"profile_image_url_https"];

    [cell.icon setImageWithURL:[NSURL URLWithString:ImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {

    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.currentlyPlaying = YES;
    self.speakButton.title = @"Pause";
    [self readTweet:[self.tweetList getTweetAtIndex:indexPath.row]];
    [self scrollToTopRowAtIndexPath:indexPath.row];
    self.tweetList.currentTweetIndex = indexPath.row;
    [self.tweetList goToNextTweet];
}


- (void) scrollToTopRowAtIndexPath: (NSInteger) index
{
    // create C array of values for NSIndexPath
    NSUInteger indexArr[] = {0, index};
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexArr length:2];
    
    //move table to new entry
    [self.tweetTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}


#pragma mark - Buttons

- (IBAction)speakButtonPressed:(id)sender
{

    if (!self.currentlyPlaying) {
        self.readingWholeList = YES;
        self.currentlyPlaying = YES;
        if (self.synthesizer.isPaused) {
            [self.synthesizer continueSpeaking];
        } else {
            [self readCurrentTweet];
        }
        self.speakButton.title = @"Pause";
        
    } else {
        self.currentlyPlaying = NO;
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
        self.speakButton.title = @"Read!";
    }
    
}


- (void)readTweet: (NSString* )text
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, text);
    self.readingWholeList = NO;
    
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];

    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self.synthesizer speakUtterance: [self buildUtteranceWithString:text]];
    
}


- (void) readCurrentTweet
{
    
    if (self.tweetList.isAtTheEnd) {
        return;
    }
    
    if (!self.currentlyPlaying) {
        return;
    }
    
    [self scrollToTopRowAtIndexPath:self.tweetList.currentTweetIndex];
    
    NSString* text = [self.tweetList getCurrentTweet];
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    [self.synthesizer speakUtterance: [self buildUtteranceWithString:text]];
    
    
    [self.tweetList goToNextTweet];
}

#pragma mark - set Utterance

- (AVSpeechUtterance*) buildUtteranceWithString: (NSString*) text
{
    AudioSynthesizer *audioSynth = [AudioSynthesizer sharedManager];

    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage: audioSynth.selectedLanguage];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString: text];
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
    NSLog(@"pitch:%f rate:%f text:%@ adjustedRate:%f ", utterance.pitchMultiplier, [audioSynth rateModifier], text, utterance.rate);

    return utterance;
}


#pragma mark AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"Finished reading tweet");
    if (self.readingWholeList) {
        [self readCurrentTweet];
    }
}

@end
