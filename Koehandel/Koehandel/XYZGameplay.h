//
//  XYZGameplay.h
//  Koehandel
//
//  Created by Boris van Linschoten on 23-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZCard.h"
#import "XYZPlayer.h"
#import "XYZDeck.h"

@interface XYZGameplay : NSObject

@property (strong, nonatomic) NSMutableArray *players;
@property XYZPlayer *currentPlayer;
@property (strong, nonatomic) NSMutableArray *waitingPlayers;
@property XYZPlayer *buyer;
@property XYZCard *currentCard;
@property NSInteger amountOfPlayers;
@property XYZDeck *deck;

@property NSMutableArray *tradeBids;
@property NSInteger bidCounter;
@property XYZPlayer *tradeEnemy;
@property NSInteger amountOfAnimalsForTrade;
@property NSString *animalForTrade;

-(BOOL) auctionCard:(XYZCard *)cardSold soldfor:(int)amount buyer:(XYZPlayer *)playerBought;
-(void) nextTurn;
-(NSMutableArray *)determineMutualAnimals;

@end
