//
//  ViewController.m
//  UIAnimationSamples
//
//  Created by Gal Cohen on 4/11/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static int curveValues[] = {
    UIViewAnimationOptionCurveEaseInOut,
    UIViewAnimationOptionCurveEaseIn,
    UIViewAnimationOptionCurveEaseOut,
    UIViewAnimationOptionCurveLinear };

- (void)viewDidLoad
{
    [super viewDidLoad];
    curvesList = [[NSMutableArray alloc] initWithObjects:@"EaseInOut",@"EaseIn",@"EaseOut",@"Linear", nil];
    selectedCurveIndex = 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Add right before @end
#pragma mark - animation actions

- (IBAction) btnMoveTo:(id)sender
{
    UIButton* button= (UIButton*)sender;
    [self.movingButton moveTo:
     CGPointMake(button.center.x - (self.movingButton.frame.size.width/2),
                 button.frame.origin.y - (self.movingButton.frame.size.height + 5.0))
                duration:1.0
                  option:curveValues[selectedCurveIndex]];	// above the tapped button
}

- (IBAction) btnDownUnder:(id)sender
{
	UIButton* button= (UIButton*)sender;
	[button downUnder:1.0 option:curveValues[selectedCurveIndex]];
}

- (IBAction) btnZoom:(id)sender
{
	UIButton* button= (UIButton*)sender;
	pickerView = [AnimationCurvePicker newAnimationCurvePicker:self];
	// the animation will start in the middle of the button
	pickerView.center = button.center;
	[self.view addSubviewWithZoomInAnimation:pickerView duration:1.0 option:curveValues[selectedCurveIndex]];
}

- (IBAction) btnHUD:(id)sender
{
	FakeHUD *theSubView = [FakeHUD newFakeHUD];
	[self.view addSubviewWithFadeAnimation:theSubView duration:1.0 option:curveValues[selectedCurveIndex]];
}


#pragma mark - animation curves picker
// handling the picker, that is a simple tableview in this example
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [curvesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	cell.textLabel.text = [curvesList objectAtIndex:indexPath.row];
    
	if (indexPath.row == selectedCurveIndex)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
    
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Select the Animation Curve to be used";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return @"Curves will not affect total duration but instant speed and acceleration";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	if (selectedCurveIndex != indexPath.row)
	{
		NSIndexPath *oldPath = [NSIndexPath indexPathForRow:selectedCurveIndex inSection:indexPath.section];
		cell = [tableView cellForRowAtIndexPath:oldPath];
		cell.accessoryType = UITableViewCellAccessoryNone;
        
		selectedCurveIndex = indexPath.row;
	}
    
	if (pickerView)
	{
		[pickerView removeWithZoomOutAnimation:1.0 option:curveValues[selectedCurveIndex]];
		pickerView = nil;
	}
}


@end
