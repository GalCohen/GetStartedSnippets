//
//  ViewController.h
//  TableViewExample
//
//  Created by Gal Cohen on 10/9/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *courses;
@property (nonatomic, strong) NSArray *courseKeys;

@property (nonatomic, strong) NSDictionary *courses_web;
@property (nonatomic, strong) NSArray *courseKeys_web;

@end
