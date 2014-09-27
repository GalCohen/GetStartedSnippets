//
//  ViewController.m
//  MPCDemo
//
//  Created by Gal Cohen on 4/7/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) int secretNumber;
@property (nonatomic) BOOL hasCreatedGame;
@property (nonatomic) BOOL isGameRunning;

@end

@implementation ViewController

#pragma mark - ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self toggleSubviewsState:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleReceivedDataWithNotification:)
                                                 name:@"MPCDemo_DidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)startGame:(id)sender {
    if (!self.isGameRunning) {
        UIAlertView *newGameAlert = [[UIAlertView alloc] initWithTitle:@"MPCDemo"
                                                               message:@"Please enter a number between 1 and 100:"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"Start Game", nil];
        
        newGameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[newGameAlert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [newGameAlert show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput && buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        self.secretNumber = [textField.text intValue];
        
        // Make sure that the given number is between 1 and 100.
        if (self.secretNumber >= 1 && self.secretNumber <= 100) {
            // Create a message to tell other players that a new game has been created,
            // convert it to a NSData object and send it.
            NSString *messageToSend = @"New Game";
            NSData *messageAsData = [messageToSend dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            
            [self.appDelegate.mpcHandler.session sendData:messageAsData
                                                  toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                                 withMode:MCSessionSendDataReliable
                                                    error:&error];
            
            // If any error occurs, just log it.
            // Otherwise set the following couple of flags to YES, indicating that the current player is the creator
            // of the game and a game is in progress.
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
                
            } else{
                self.hasCreatedGame = YES;
                self.isGameRunning = YES;
                
                [self.tvHistory setText:@""];
            }
            
        } else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MPCDemo"
                                                            message:@"Please enter a valid number."
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Okay", nil];
            [alert show];
        }
    } else {

        // Get the tapped button's title as the answer, convert it to a NSData object and send it to other players.
        NSString *selectedAnswer = [alertView buttonTitleAtIndex:buttonIndex];
        NSData *answerAsData = [selectedAnswer dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        [self.appDelegate.mpcHandler.session sendData:answerAsData
                                              toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                             withMode:MCSessionSendDataReliable
                                                error:&error];
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        // In case of correct guess then turn the flags to off.
        if (buttonIndex == 0) {
            self.hasCreatedGame = NO;
            self.isGameRunning = NO;
        }
    
    }
}


- (void)toggleSubviewsState:(BOOL)shouldEnable {
    self.btnCancel.enabled = shouldEnable;
    self.txtGuess.enabled = shouldEnable;
    self.btnSend.enabled = shouldEnable;
}


- (void)handleReceivedDataWithNotification:(NSNotification *)notification {
    // Get the user info dictionary that was received along with the notification.
    NSDictionary *userInfoDict = [notification userInfo];
    
    // Convert the received data into a NSString object.
    NSData *receivedData = [userInfoDict objectForKey:@"data"];
    NSString *message = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    // Keep the sender's peerID and get its display name.
    MCPeerID *senderPeerID = [userInfoDict objectForKey:@"peerID"];
    NSString *senderDisplayName = senderPeerID.displayName;
    
    if ([message isEqualToString:@"New Game"]) {
        // In case the message is about a new game, then show an alert view telling that the sender of the message
        // has just started a new game.
        NSString *alertMessage = [NSString stringWithFormat:@"%@ has started a new game.", senderDisplayName];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MPCDemo"
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Done", nil];
        
        [alert show];
        
        // Also, indicate that a game is in progress.
        self.isGameRunning = YES;
        
        // Enable all subviews.
        [self toggleSubviewsState:YES];
        
        // Clear all previous history from the text view.
        [self.tvHistory setText:@""];
    } else {
        // Check if the message contains only digits. If that's the case, then
        // that means that it contains a guess from the player who sent it.
        NSCharacterSet *numbersSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *messageSet = [NSCharacterSet characterSetWithCharactersInString:message];
        
        if ([numbersSet isSupersetOfSet:messageSet]) {
            // The message contains the guess from another player.
            // Convert it to a number.
            int guess = [message intValue];
            
            // Add this guess to the history text view.
            NSString *history = [NSString stringWithFormat:@"Player %@ guessed the number: %d\n\n", senderDisplayName, guess];
            [self.tvHistory setText:[history stringByAppendingString:self.tvHistory.text]];
            
            // If self is the game creator, then show all available options regarding this guess.
            if (self.hasCreatedGame) {
                NSString *optionsMessage = [NSString stringWithFormat:@"%@\n\nThe secret number is %d.\n\nWhat's your answer?", history, self.secretNumber];
                UIAlertView *optionsAlert = [[UIAlertView alloc] initWithTitle:@"MPCDemo"
                                                                       message:optionsMessage
                                                                      delegate:self
                                                             cancelButtonTitle:nil
                                                             otherButtonTitles:@"Correct Guess!", @"Give a greater number", @"Give a lower number", nil];
                [optionsAlert show];
            }
        } else {
            // If the message doesn't contain digits, then it contains the answer from the player who started the game.
            // For starters, just show answer to the history text view.
            NSString *history = [NSString stringWithFormat:@"%@ says:\n%@\n\n", senderDisplayName, message];
            [self.tvHistory setText:[history stringByAppendingString:self.tvHistory.text]];
            
            // Check if the game creator answered that the last guess was the correct one. In that case, the game
            // should stop.
            if ([message isEqualToString:@"Correct Guess!"]) {
                self.isGameRunning = NO;
                
                [self toggleSubviewsState:NO];
            }
        }
    }
}



#pragma mark - actions

- (IBAction)sendGuess:(id)sender {
    // Check if a number has been entered or not, and if it's valid.
    if (self.txtGuess.text.length == 0 || [self.txtGuess.text intValue] < 1 || [self.txtGuess.text intValue] > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MPCDemo"
                                                        message:@"Please enter a valid number."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Okay", nil];
        [alert show];
        
    } else{
        // Convert the guess string to a NSData object and send it to all peers (players).
        NSData *guessAsData = [self.txtGuess.text dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        [self.appDelegate.mpcHandler.session sendData:guessAsData
                                              toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                             withMode:MCSessionSendDataReliable
                                                error:&error];
        
        // If any error occurs just log its description.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        // Add to the history text view the number value given by the current player.
        NSString *history = [NSString stringWithFormat:@"I guessed the number: %@\n\n", self.txtGuess.text];
        [self.tvHistory setText:[history stringByAppendingString:self.tvHistory.text]];
    }
    
    self.txtGuess.text = @"";
    [self.txtGuess resignFirstResponder];
}

- (IBAction)cancelGuessing:(id)sender {
    [self.txtGuess resignFirstResponder];
}


@end
