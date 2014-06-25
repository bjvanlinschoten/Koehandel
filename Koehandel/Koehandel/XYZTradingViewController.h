//
//  XYZTradingViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 24-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZDeck.h"
#import "XYZCard.h"
#import "XYZPlayer.h"
#import "XYZGameplay.h"
#import "XYZTabBarViewController.h"
#import "XYZBiddingViewController.h"

@interface XYZTradingViewController : UIViewController <UIPickerViewDataSource, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource>

@property XYZGameplay *gp;
@property (weak, nonatomic) IBOutlet UIPickerView *tradePicker;
@property (weak, nonatomic) IBOutlet UIButton *tradeButton;
@property NSMutableArray *mutualAnimals;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

- (IBAction)trade:(id)sender;

@end
