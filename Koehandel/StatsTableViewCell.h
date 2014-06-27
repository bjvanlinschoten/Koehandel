//
//  StatsTableViewCell.h
//  Koehandel
//
//  Created by Boris van Linschoten on 27-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *animalImage;
@property (weak, nonatomic) IBOutlet UILabel *animalAmount;

@end
