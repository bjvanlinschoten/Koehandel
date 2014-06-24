//
//  XYZViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZDeck.h"
#import "XYZCard.h"
#import "XYZPlayer.h"
#import "XYZGameplay.h"

@interface XYZAuctionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cardsRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *animalImage;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UIButton *waitingPlayer2BuysButton;
@property (weak, nonatomic) IBOutlet UIButton *waitingPlayer1BuysButton;
@property NSString *name1;
@property NSString *name2;
@property NSString *name3;

- (IBAction)drawCard:(id)sender;
- (void)nextTurn;
- (IBAction)waitingPlayer1Buys:(id)sender;
- (IBAction)waitingPlayer2Buys:(id)sender;

@end
