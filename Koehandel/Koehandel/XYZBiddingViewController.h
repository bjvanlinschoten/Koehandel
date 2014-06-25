//
//  XYZBiddingViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 25-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZGameplay.h"

@interface XYZBiddingViewController : UIViewController

@property XYZGameplay *gp;
@property XYZPlayer *attacker;
@property XYZPlayer *defender;
@property NSString *animal;
@property NSInteger amount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@end
