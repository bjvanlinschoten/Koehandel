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

@interface XYZGameplay : NSObject

@property XYZPlayer *player1;
@property XYZPlayer *player2;
@property XYZPlayer *player3;
@property XYZPlayer *currentPlayer;
@property XYZPlayer *waitingPlayer1;
@property XYZPlayer *waitingPlayer2;
@property XYZPlayer *buyer;
@property XYZCard *currentCard;

-(void) auctionCard:(XYZCard *)cardSold soldfor:(int)amount buyer:(XYZPlayer *)playerBought;


@end
