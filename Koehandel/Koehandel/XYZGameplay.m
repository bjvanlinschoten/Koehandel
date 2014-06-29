//
//  XYZGameplay.m
//  Koehandel
//
//  Created by Boris van Linschoten on 23-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZGameplay.h"

@implementation XYZGameplay

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.players = [[NSMutableArray alloc] init];
        self.waitingPlayers = [[NSMutableArray alloc] init];
        self.deck = [[XYZDeck alloc] init];
        self.donkeys = 0;
    }
    return self;
}

-(BOOL)auctionCard:(XYZCard *)cardSold soldFor:(int)amount{
    
    // if buyer can afford the sell
    if ([self.buyer getTotalMoney] >= amount) {
        int possibleMoneyCards[6] = {0, 10, 50, 100, 200, 500};
        int i = 5;
        
        // perform the sell by most optimal combination of cards
        // (in this game it is ALWAYS optimal for the player to pay with the smallest possible amount of money cards)
        while (amount > 0) {
            int moneyValueBelowCardI = 0;
            for (int j = 0; j < i; j++) {
                moneyValueBelowCardI += [self.buyer.moneyCards[j] integerValue] * possibleMoneyCards[j];
            }
            
            if (amount >= possibleMoneyCards[i] || moneyValueBelowCardI < amount) {
                if ([self.buyer.moneyCards[i] integerValue] > 0) {
                    self.buyer.moneyCards[i] = [NSNumber numberWithInt:[self.buyer.moneyCards[i] integerValue] - 1];
                    self.seller.moneyCards[i] = [NSNumber numberWithInt:[self.seller.moneyCards[i] integerValue] + 1];
                    amount = amount - possibleMoneyCards[i];
                }
                else {
                    i--;
                }
            }
            else {
                i--;
            }
        }
        
        // determine animal index
        int animalIndex;
        for (int i = 0; i < 10; i++) {
            if ([[self.deck.animals objectAtIndex:i] isEqualToString:cardSold.animal]) {
                animalIndex = i;
                break;
            }
        }
        
        // add the animal card to the players cards
        self.buyer.animalCards[animalIndex] = [NSNumber numberWithInt:[self.buyer.animalCards[animalIndex] integerValue] + 1];
        
        return true;
    }
    // if he cant afford the sell, return false
    else {
        return false;
    }
}

// rotate the players
-(void)nextTurn {
    XYZPlayer *tempPlayer = [XYZPlayer alloc];
    tempPlayer = self.currentPlayer;
    self.currentPlayer = [self.waitingPlayers objectAtIndex:0];
    [self.waitingPlayers removeObjectAtIndex:0];
    [self.waitingPlayers addObject:tempPlayer];
}

-(NSMutableArray *)determineMutualAnimals {
    NSMutableArray *mutualAnimals = [[NSMutableArray alloc] init];
    
    // loop through all waiting players
    for (int i = 0; i < [self.waitingPlayers count]; i++) {
        
        // array for mutual animals with player i
        NSMutableArray *mutualAnimalsWithPlayerI = [[NSMutableArray alloc] init];
       
        // loop through all their animals
        for (int j = 0; j < 10; j++) {
            
            // if player has 1 animal of some sort and player i 1 or more
            if ([[[[self.waitingPlayers objectAtIndex:i] animalCards] objectAtIndex:j] integerValue] == 1 &&
                [[[self.currentPlayer animalCards] objectAtIndex:j] integerValue] > 0) {
                [mutualAnimalsWithPlayerI addObject:[[NSArray alloc] initWithObjects:[self.deck.animals objectAtIndex:j], [NSNumber numberWithInt:1], nil]];
            }
            
            // if player had 2 animals and player i 2 or more
            else if ([[[[self.waitingPlayers objectAtIndex:i] animalCards] objectAtIndex:j] integerValue] == 2 &&
                     [[[self.currentPlayer animalCards] objectAtIndex:j] integerValue] >= 2) {
                [mutualAnimalsWithPlayerI addObject:[[NSArray alloc] initWithObjects:[self.deck.animals objectAtIndex:j], [NSNumber numberWithInt:2], nil]];
            }
        }
        
        // update array with all mutual animals with all players
        if ([mutualAnimalsWithPlayerI count] > 0) {
            [mutualAnimalsWithPlayerI addObject:[self.waitingPlayers objectAtIndex:i]];
            [mutualAnimals addObject:mutualAnimalsWithPlayerI];
        }
    }
    return mutualAnimals;
}

- (XYZPlayer *)trade {
    
    // give the trading players eachother's bids
    for (int i = 0; i < 6; i++) {
        self.currentPlayer.moneyCards[i] = [NSNumber numberWithInt:[self.currentPlayer.moneyCards[i] integerValue] + [[[self.tradeBids objectAtIndex:1] objectAtIndex:i] integerValue]];
        self.tradeEnemy.moneyCards[i] = [NSNumber numberWithInt:[self.tradeEnemy.moneyCards[i] integerValue] + [[[self.tradeBids objectAtIndex:0] objectAtIndex:i] integerValue]];
    }
    
    // determine animal index
    int animalIndex = [[self.deck.animalDict objectForKey:self.animalForTrade] integerValue];
    
    // determine the player that won and move the animal(s) from loser to winner and return winner (NULL on draw)
    if ([[[self.tradeBids objectAtIndex:0] lastObject] integerValue] > [[[self.tradeBids objectAtIndex:1] lastObject] integerValue]) {
        self.currentPlayer.animalCards[animalIndex] = [NSNumber numberWithInt:[self.currentPlayer.animalCards[animalIndex] integerValue] + self.amountOfAnimalsForTrade];
        self.tradeEnemy.animalCards[animalIndex] = [NSNumber numberWithInt:[self.tradeEnemy.animalCards[animalIndex] integerValue] - self.amountOfAnimalsForTrade];
        return self.currentPlayer;
    }
    else if ([[[self.tradeBids objectAtIndex:0] lastObject] integerValue] < [[[self.tradeBids objectAtIndex:1] lastObject] integerValue]) {
        self.tradeEnemy.animalCards[animalIndex] = [NSNumber numberWithInt:[self.tradeEnemy.animalCards[animalIndex] integerValue] + self.amountOfAnimalsForTrade];
        self.currentPlayer.animalCards[animalIndex] = [NSNumber numberWithInt:[self.currentPlayer.animalCards[animalIndex] integerValue] - self.amountOfAnimalsForTrade];
        return self.tradeEnemy;
    }
    else {
        return NULL;
    }
}


@end
