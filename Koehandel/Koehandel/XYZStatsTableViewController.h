//
//  XYZStatsTableViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 27-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZStatsDataSourceViewController.h"
#import "StatsTableViewCell.h"
#import "XYZStatsMoneyTableViewController.h"

@interface XYZStatsTableViewController : UITableViewController

@property NSUInteger pageIndex;
@property XYZPlayer *player;
@property XYZDeck *deck;

@end
