//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Gal Cohen on 4/2/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
