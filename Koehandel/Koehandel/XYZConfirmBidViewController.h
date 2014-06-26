//
//  XYZConfirmBidViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZBiddingViewController.h"

@interface XYZConfirmBidViewController : UIViewController

@property XYZGameplay *gp;
@property (weak, nonatomic) IBOutlet UILabel *player1BidLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2BidLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

- (IBAction)confirm:(id)sender;

@end
