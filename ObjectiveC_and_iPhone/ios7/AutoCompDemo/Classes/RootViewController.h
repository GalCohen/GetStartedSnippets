//
//  RootViewController.h
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright 2009 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
  IBOutlet UITextField *urlField;
  WebViewController *webViewController;
  NSMutableArray *pastUrls;
  NSMutableArray *autocompleteUrls;
  UITableView *autocompleteTableView;
}

@property (nonatomic, retain) UITextField *urlField;
@property (nonatomic, retain) WebViewController *webViewController;
@property (nonatomic, retain) NSMutableArray *pastUrls;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (nonatomic, retain) UITableView *autocompleteTableView;

- (IBAction)goPressed;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end
