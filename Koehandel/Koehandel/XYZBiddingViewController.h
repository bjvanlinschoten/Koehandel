//
//  XYZBiddingViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 25-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZGameplay.h"
#import "XYZPlayer.h"
#import "XYZTradingViewController.h"

@interface XYZBiddingViewController : UIViewController

@property XYZGameplay *gp;
@property XYZPlayer *bidder;
@property NSInteger totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property IBOutletCollection(UILabel) NSArray *amountCardsLabels;
@property (strong, nonatomic) IBOutletCollection(UIStepper) NSArray *cardSteppers;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property BOOL completed;


- (IBAction)stepperValueChanged:(id)sender;
- (IBAction)placeBet:(id)sender;

@end
