//
//  ViewController.m
//  TableViewExample
//
//  Created by Gal Cohen on 10/9/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize courseKeys;
@synthesize courses;

@synthesize courseKeys_web;
@synthesize courses_web;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return [courses count];
    }else{
        return [courses_web count];
    }
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0){
        return @"iOS courses";
    }else{
        return @"Web courses";
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    
    NSString *currentCourseName = [courseKeys objectAtIndex:indexPath.row];
    
    //which section are we in?
    if ([indexPath section] == 0){
        currentCourseName = [courseKeys objectAtIndex:indexPath.row];
    }else {
        currentCourseName = [courseKeys_web objectAtIndex:indexPath.row];
    }
   
    [[cell textLabel] setText:currentCourseName];
    
    //Now, get the author name
    NSString *currentAuthorName;
    if ([indexPath section] == 0){
        currentAuthorName = [courses objectForKey:[courseKeys objectAtIndex:indexPath.row]];
    }else{
        currentAuthorName = [courses objectForKey:[courseKeys_web objectAtIndex:indexPath.row]];
    }
    [[cell detailTextLabel] setText:currentAuthorName];
    
    
    //Retrieve an image
    NSString *imagefile = [[NSBundle mainBundle] pathForResource:@"cellimage" ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagefile];
    
    //Adds the image to the table cell
    [[cell imageView] setImage:image];
    
    //accessory type
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *myFile = [[NSBundle mainBundle] pathForResource:@"courses" ofType:@"plist"];
    
    courses = [[NSDictionary alloc] initWithContentsOfFile:myFile];
    courseKeys = [courses allKeys];
    
    //loading web courses
    myFile = [[NSBundle mainBundle] pathForResource:@"courses_web" ofType:@"plist"];
    courses_web = [[NSDictionary alloc] initWithContentsOfFile:myFile];
    courseKeys_web = [courses_web allKeys];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
