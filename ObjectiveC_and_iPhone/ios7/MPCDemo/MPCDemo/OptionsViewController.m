//
//  OptionsViewController.m
//  MPCDemo
//
//  Created by Gal Cohen on 4/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "OptionsViewController.h"
#import "AppDelegate.h"

@interface OptionsViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;

@end

@implementation OptionsViewController

#pragma mark - ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txtPlayerName.delegate = self;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self.appDelegate.mpcHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [self.appDelegate.mpcHandler setupSession];
    [self.appDelegate.mpcHandler advertiseSelf:self.swVisible.isOn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerChangedStateWithNotification:)
                                                 name:@"MPCDemo_DidChangeStateNotification"
                                               object:nil];
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)searchForPlayers:(id)sender {
    if (self.appDelegate.mpcHandler.session != nil) {
        [[self.appDelegate mpcHandler] setupBrowser];
        [[[self.appDelegate mpcHandler] browser] setDelegate:self];
        [self presentViewController:self.appDelegate.mpcHandler.browser
                           animated:YES
                         completion:nil];
    }
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (IBAction)disconnect:(id)sender {
    [self.appDelegate.mpcHandler.session disconnect];
}


- (IBAction)toggleVisibility:(id)sender {
    [self.appDelegate.mpcHandler advertiseSelf:self.swVisible.isOn];
}

#pragma mark - MCBrowserViewController Delegates

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
   
}


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Notification Handling

- (void)peerChangedStateWithNotification:(NSNotification *)notification {
    // Get the state of the peer.
    int state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    // We care only for the Connected and the Not Connected states.
    // The Connecting state will be simply ignored.
    if (state != MCSessionStateConnecting) {
        // We'll just display all the connected peers (players) to the text view.
        NSString *allPlayers = @"Other players connected with:\n\n";
        
        for (int i = 0; i < self.appDelegate.mpcHandler.session.connectedPeers.count; i++) {
            NSString *displayName = [[self.appDelegate.mpcHandler.session.connectedPeers objectAtIndex:i] displayName];
            
            allPlayers = [allPlayers stringByAppendingString:@"\n"];
            allPlayers = [allPlayers stringByAppendingString:displayName];
        }
        
        [self.tvPlayerList setText:allPlayers];
    }
}


#pragma mark - TextView Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.txtPlayerName resignFirstResponder];
    
    if (self.appDelegate.mpcHandler.peerID != nil) {
        [self.appDelegate.mpcHandler.session disconnect];
        
        self.appDelegate.mpcHandler.peerID = nil;
        self.appDelegate.mpcHandler.session = nil;
    }
    
    [self.appDelegate.mpcHandler setupPeerWithDisplayName:self.txtPlayerName.text];
    [self.appDelegate.mpcHandler setupSession];
    [self.appDelegate.mpcHandler advertiseSelf:self.swVisible.isOn];
    
    return YES;
}


@end
