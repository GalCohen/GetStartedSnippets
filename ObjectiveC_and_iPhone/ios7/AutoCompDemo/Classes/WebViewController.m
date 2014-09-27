//
//  WebViewController.m
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright 2009 Ray Wenderlich. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
@synthesize webView;
@synthesize url;
@synthesize activity;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)viewWillAppear:(BOOL)animated {
  NSString *fullUrl = [[NSString alloc] initWithFormat:@"http://%@", self.url];
  NSURL *aboutURL = [[NSURL alloc] initWithString:fullUrl];
  [fullUrl release];
  [webView loadRequest:[NSURLRequest requestWithURL:aboutURL]];
  [super viewWillAppear:animated];

}

- (void)dealloc {
  [webView release];
  [url release];
  [activity release];
  [super dealloc];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  activity.hidden = FALSE;
  [activity stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  activity.hidden = TRUE;
  [activity startAnimating];
  
  NSURLRequest *currentRequest = [webView request];
  NSURL *currentURL = [currentRequest URL];
  NSLog(@"Current URL is %@", currentURL.absoluteString);
  }

@end
