//
//  WebViewController.h
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright 2009 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate> {
  UIWebView *webView;
  NSString *url;
  UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

@end
