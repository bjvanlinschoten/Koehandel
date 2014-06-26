//
//  XYZTabBarViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 25-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZAuctionViewController.h"
#import "XYZStatsPageViewController.h"
#import "XYZTradingViewController.h"

@interface XYZTabBarViewController : UITabBarController

@property XYZGameplay *gp;
@property BOOL turnDecided;

@end
