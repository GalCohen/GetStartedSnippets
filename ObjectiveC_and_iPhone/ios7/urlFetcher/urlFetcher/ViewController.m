//
//  ViewController.m
//  urlFetcher
//
//  Created by Gal Cohen on 2/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableData   *buffer;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)makeRequest:(id)sender {
    NSLog(@"%s",__func__);
    /* disable the fetch button during the request */
    [self.fetchButton setEnabled:NO];
    
    /* begin animating the spinner */
    [self.spinner startAnimating];
    
    /* create the request */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"]];
    
    /* create the connection */
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    /* ensure the connection was created */
    if (self.connection)
    {
        /* initialize the buffer */
        self.buffer = [NSMutableData data];
        
        /* start the request */
        [self.connection start];
    }
    else
    {
        self.textField.text = @"Connection Failed";
    }
}

- (IBAction)clear:(id)sender {
    NSLog(@"%s",__func__);
    self.textField.text = @"";
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /* clear the connection &amp; the buffer */
    self.connection = nil;
    self.buffer     = nil;
    
    self.textField.text = [error localizedDescription];
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    /* reset the buffer length each time this is called */
    [self.buffer setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    /* Append data to the buffer */
    [self.buffer appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /* dispatch off the main queue for json processing */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error = nil;
        NSString *jsonString = [[NSJSONSerialization JSONObjectWithData:_buffer options:0 error:&error] description];
        
        /* dispatch back to the main queue for UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* check for a JSON error */
            if (!error)
            {
                self.textField.text = jsonString;
            }
            else
            {
                self.textField.text = [error localizedDescription];
            }
            
            /* stop animating &amp; re-enable the fetch button */
            [self.spinner stopAnimating];
            [self.fetchButton setEnabled:YES];
            
            /* clear the connection &amp; the buffer */
            self.connection = nil;
            self.buffer     = nil;
        });
        
    });
}

@end
