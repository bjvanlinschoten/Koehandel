//
//  XYZTableWithStatsViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 27-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatsTableViewCell.h"
#import "XYZStatsDataSourceViewController.h"

@interface XYZTableWithStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSUInteger pageIndex;
@property XYZPlayer *player;
@property XYZDeck *deck;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;

@end
