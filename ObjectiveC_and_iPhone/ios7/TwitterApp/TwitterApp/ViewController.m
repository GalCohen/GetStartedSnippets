//
//  ViewController.m
//  TwitterApp
//
//  Created by Gal Cohen on 3/24/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
                          ]
        
    ;
//    NSData* data = [jsonTest dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSError* error;
//    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    if (error) {
//        NSLog(@"ERROR: %@", [error description]);
//    }
    self.dataSource = jsonTest;
    NSLog(@"%@", self.dataSource);
    [self.tweetTableView reloadData];
    [self getTimeLine];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getTimeLine {
    NSLog(@"%s", __PRETTY_FUNCTION__);
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
                     NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                     
                     NSLog(@"%lu", (unsigned long)self.dataSource.count);
                     NSLog(@"%@", jsonString);
                     
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

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tweetTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = self.dataSource[[indexPath row]];
    
    cell.textLabel.text = tweet[@"text"];
    return cell;
}

@end
