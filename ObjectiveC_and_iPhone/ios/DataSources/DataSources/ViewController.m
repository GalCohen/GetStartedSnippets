//
//  ViewController.m
//  DataSources
//
//  Created by Gal Cohen on 10/9/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize moodList;

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [moodList count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [moodList objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UIColor *newColor;
    
    switch(row){
        case 0: case 1: case 2:
            newColor = [UIColor yellowColor];
            break;
        case 3: case 4: case 5:
             newColor = [UIColor grayColor];
            break;
        case 6: case 7: case 8:
             newColor = [UIColor blackColor];
            break;
        default:
            newColor = [UIColor redColor];
            break;
    }
    self.view.backgroundColor = newColor;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    moodList = [[NSArray alloc] initWithObjects:@"Ecstatic", @"Happy", @"Cheerful", @"Fine", @"Tired", @"Maudlin", @"Depressed", @"Overwhelmed", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
