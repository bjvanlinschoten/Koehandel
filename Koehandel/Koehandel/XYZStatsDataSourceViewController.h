//
//  XYZStatsDataSourceViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZTabBarViewController.h"

@interface XYZStatsDataSourceViewController : UIViewController <UIPageViewControllerDataSource>

@property XYZGameplay *gp;
@property (strong, nonatomic) XYZStatsPageViewController *statsPageViewController;

- (XYZStatsContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
