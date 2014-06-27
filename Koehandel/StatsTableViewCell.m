//
//  StatsTableViewCell.m
//  Koehandel
//
//  Created by Boris van Linschoten on 27-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "StatsTableViewCell.h"

@implementation StatsTableViewCell

@synthesize animalImage,animalAmount;

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
