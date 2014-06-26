//
//  XYZStatsContentViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZStatsPageViewController.h"

@interface XYZStatsContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property NSUInteger pageIndex;
@property XYZPlayer *player;

@end