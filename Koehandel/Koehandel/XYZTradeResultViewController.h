//
//  XYZTradeResultViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZConfirmBidViewController.h"

@interface XYZTradeResultViewController : UIViewController

@property XYZGameplay *gp;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

- (IBAction)back:(id)sender;

@end
