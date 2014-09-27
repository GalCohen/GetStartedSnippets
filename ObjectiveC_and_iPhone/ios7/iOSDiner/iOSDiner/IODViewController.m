//
//  IODViewController.m
//  iOSDiner
//
//  Created by Gal Cohen on 2/10/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "IODViewController.h"
#import "IODItem.h"
#import "IODOrder.h"

@interface IODViewController ()

@end

@implementation IODViewController

@synthesize inventory;
@synthesize order;
@synthesize ibRemoveItemButton;
@synthesize ibAddItemButton;
@synthesize ibPreviousItemButton;
@synthesize ibNextItemButton;
@synthesize ibTotalOrderButton;
@synthesize ibChalkboardLabel;
@synthesize ibCurrentItemImageView;
@synthesize ibCurrentItemLabel;

dispatch_queue_t queue;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    currentItemIndex = 0;
    self.order = [IODOrder new];
    queue = dispatch_queue_create("com.adamburkepile.queue",nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    // 0 - Update buttons
    [self updateInventoryButtons];
    
    // 1 - Set initial label text
	ibChalkboardLabel.text = @"Loading Inventory...";
//	// 2 - Get inventory
//	self.inventory = [[IODItem retrieveInventoryItems] mutableCopy];
//	// 3 - Set inventory loaded text
//	_ibChalkboardLabel.text = @"Inventory Loaded\n\nHow can I help you?";
    
   	// 2 - Use queue to fetch inventory and then then update UI
	dispatch_async(queue, ^{
		self.inventory = [[IODItem retrieveInventoryItems] mutableCopy];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self updateOrderBoard]; // <---- Add
			[self updateInventoryButtons];
			[self updateCurrentInventoryItem];
			self.ibChalkboardLabel.text = @"Inventory Loaded\n\nHow can I help you?";
		});
	});

}

// no longer needed in ios7
//-(void)dealloc {
//    dispatch_release(queue);
//}

- (IBAction)ibaRemoveItem:(id)sender {
    NSLog(@"removeItem");
    IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
    [order removeItemFromOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
    
    UILabel* removeItemDisplay = [[UILabel alloc] initWithFrame:ibCurrentItemImageView.frame];
    [removeItemDisplay setCenter:ibChalkboardLabel.center];
    [removeItemDisplay setText:@"-1"];
    [removeItemDisplay setTextAlignment:UITextAlignmentCenter];
    [removeItemDisplay setTextColor:[UIColor redColor]];
    [removeItemDisplay setBackgroundColor:[UIColor clearColor]];
    [removeItemDisplay setFont:[UIFont boldSystemFontOfSize:32.0]];
    [[self view] addSubview:removeItemDisplay];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         [removeItemDisplay setCenter:[ibCurrentItemImageView center]];
                         [removeItemDisplay setAlpha:0.0];
                     } completion:^(BOOL finished) {
                         [removeItemDisplay removeFromSuperview];
                     }];
    NSLog(@"removeItem...done");

}

- (IBAction)ibaAddItem:(id)sender {
    NSLog(@"addItem");
    IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
    [order addItemToOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
    
    UILabel* addItemDisplay = [[UILabel alloc] initWithFrame:ibCurrentItemImageView.frame];
    [addItemDisplay setText:@"+1"];
    [addItemDisplay setTextColor:[UIColor whiteColor]];
    [addItemDisplay setBackgroundColor:[UIColor clearColor]];
    [addItemDisplay setTextAlignment:UITextAlignmentCenter];
    [addItemDisplay setFont:[UIFont boldSystemFontOfSize:32.0]];
    [[self view] addSubview:addItemDisplay];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         [addItemDisplay setCenter:ibChalkboardLabel.center];
                         [addItemDisplay setAlpha:0.0];
                         NSLog(@"addItem...animation cb");
                     } completion:^(BOOL finished) {
                         NSLog(@"addItem...cb done");
                         [addItemDisplay removeFromSuperview];
                     }];
    NSLog(@"addItem...done");
}

- (IBAction)ibaLoadPreviousItem:(id)sender {
    NSLog(@"loadPreviousItem");
    currentItemIndex--;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
    NSLog(@"loadPreviousItem...done");
}

- (IBAction)ibaLoadNextItem:(id)sender {
    NSLog(@"loadNextItem");
    currentItemIndex++;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
    NSLog(@"loadNextItem...done");
}

- (void)updateCurrentInventoryItem {
    if (currentItemIndex >= 0 && currentItemIndex < [self.inventory count]) {
        IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        ibCurrentItemLabel.text = currentItem.name;
        ibCurrentItemImageView.image = [UIImage imageNamed:[currentItem pictureFile]];
    }
}

- (void)updateInventoryButtons {
    if (!self.inventory || [self.inventory count] == 0) {
        ibAddItemButton.enabled = NO;
        ibRemoveItemButton.enabled = NO;
        ibNextItemButton.enabled = NO;
        ibPreviousItemButton.enabled = NO;
        ibTotalOrderButton.enabled = NO;
    } else {
        if (currentItemIndex <= 0) {
            ibPreviousItemButton.enabled = NO;
        } else {
            ibPreviousItemButton.enabled = YES;
        }
        if (currentItemIndex >= [self.inventory count]-1) {
            ibNextItemButton.enabled = NO;
        } else {
            ibNextItemButton.enabled = YES;
        }
        IODItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        if (currentItem) {
            ibAddItemButton.enabled = YES;
        } else {
            ibAddItemButton.enabled = NO;
        }
        if (![self.order findKeyForOrderItem:currentItem]) {
            ibRemoveItemButton.enabled = NO;
        } else {
            ibRemoveItemButton.enabled = YES;
        }
        if ([order.orderItems count] == 0) {
            ibTotalOrderButton.enabled = NO;
        } else {
            ibTotalOrderButton.enabled = YES;
        }
    }
}

- (void)updateOrderBoard {
    if ([order.orderItems count] == 0) {
        //self. accesses the same var as _xxx does
        self.ibChalkboardLabel.text = @"No Items. Please order something!";
    } else {
        self.ibChalkboardLabel.text = [order orderDescription];
    }
}

- (IBAction)ibaCalculateTotal:(id)sender {
    float total = [order totalOrder];
    UIAlertView* totalAlert = [[UIAlertView alloc] initWithTitle:@"Total"
                                                         message:[NSString stringWithFormat:@"$%0.2f",total]
                                                        delegate:nil
                                               cancelButtonTitle:@"Close"
                                               otherButtonTitles:nil];
    [totalAlert show];
}



@end
