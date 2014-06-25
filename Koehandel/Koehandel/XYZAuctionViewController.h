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
#import "XYZTabBarViewController.h"

@interface XYZAuctionViewController : UIViewController <UIActionSheetDelegate>

@property XYZGameplay *gp;
@property (weak, nonatomic) IBOutlet UILabel *cardsRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *animalImage;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UIButton *drawCardButton;
@property (weak, nonatomic) IBOutlet UIButton *soldButton;


- (IBAction)drawCard:(id)sender;
- (void)nextTurn;
- (void)askForPlayerName:(NSInteger)player;
- (IBAction)cardSold:(id)sender;

@end
