//
//  RootViewController.m
//  WebViewDemo
//
//  Created by Ray Wenderlich on 9/17/09.
//  Copyright 2009 Ray Wenderlich. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"

@implementation RootViewController
@synthesize urlField = urlField;
@synthesize webViewController;
@synthesize pastUrls;
@synthesize autocompleteUrls;
@synthesize autocompleteTableView;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
  WebViewController *tempViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" 
                                                                             bundle:[NSBundle mainBundle]];
  self.webViewController = tempViewController;
  
  self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"www.google.com", nil];
  self.autocompleteUrls = [[NSMutableArray alloc] init];
  
  autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, 120) style:UITableViewStylePlain];
  autocompleteTableView.delegate = self;
  autocompleteTableView.dataSource = self;
  autocompleteTableView.scrollEnabled = YES;
  autocompleteTableView.hidden = YES;  
  [self.view addSubview:autocompleteTableView];
  
  
  [tempViewController release];  
  [super viewDidLoad];
}

- (void)viewDidUnload {
}

- (IBAction)goPressed {
  
  // Clean up UI
  [urlField resignFirstResponder];
  autocompleteTableView.hidden = YES;
  
  // Tell the web view controller where to go
  webViewController.url = urlField.text;
  
  // Add the URL to the list of entered URLS as long as it isn't already there
  if (![pastUrls containsObject:urlField.text]) {
    [pastUrls addObject:urlField.text];
  }
  
  // Push the wev view controller onto the stack
  [self.navigationController pushViewController:self.webViewController animated:YES];
}

- (void)dealloc {
  [urlField dealloc];
  [webViewController dealloc];
  [pastUrls dealloc];
  [autocompleteUrls dealloc];
  [autocompleteTableView dealloc];
  [super dealloc];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
  
  // Put anything that starts with this substring into the autocompleteUrls array
  // The items in this array is what will show up in the table view
  [autocompleteUrls removeAllObjects];
  for(NSString *curString in pastUrls) {
    NSRange substringRange = [curString rangeOfString:substring];
    if (substringRange.location == 0) {
      [autocompleteUrls addObject:curString];  
    }
  }
  [autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  autocompleteTableView.hidden = NO;
     
  NSString *substring = [NSString stringWithString:textField.text];
  substring = [substring stringByReplacingCharactersInRange:range withString:string];
  [self searchAutocompleteEntriesWithSubstring:substring];
  return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
  return autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  UITableViewCell *cell = nil;
  static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
  cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] 
             initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] autorelease];
  }
  
  cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
  return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
  urlField.text = selectedCell.textLabel.text;
  
  [self goPressed];
  
}

@end
