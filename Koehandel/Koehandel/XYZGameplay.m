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
    }
    return self;
}

-(BOOL)auctionCard:(XYZCard *)cardSold soldfor:(int)amount buyer:(XYZPlayer *)buyer {
    if ([buyer getTotalMoney] > amount) {
        int possibleMoneyCards[6] = {0, 10, 50, 100, 200, 500};
        int i = 5;
        while (amount > 0) {
            int moneyValueBelowCardI = 0;
            for (int j = 0; j < i; j++) {
                moneyValueBelowCardI += [buyer.moneyCards[j] integerValue] * possibleMoneyCards[j];
            }
            
            if (amount >= possibleMoneyCards[i] || moneyValueBelowCardI < amount) {
                if ([buyer.moneyCards[i] integerValue] > 0) {
                    buyer.moneyCards[i] = [NSNumber numberWithInt:[buyer.moneyCards[i] integerValue] - 1];
                    self.currentPlayer.moneyCards[i] = [NSNumber numberWithInt:[self.currentPlayer.moneyCards[i] integerValue] + 1];
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
        int animalIndex;
        for (int i = 0; i < 10; i++) {
            if ([[self.deck.animals objectAtIndex:i] isEqualToString:cardSold.animal]) {
                animalIndex = i;
                break;
            }
        }
        buyer.animalCards[animalIndex] = [NSNumber numberWithInt:[buyer.animalCards[animalIndex] integerValue] + 1];
        return true;
    }
    else {
        return false;
    }
}

-(void)nextTurn {
    XYZPlayer *tempPlayer = [XYZPlayer alloc];
    tempPlayer = self.currentPlayer;
    self.currentPlayer = [self.waitingPlayers objectAtIndex:0];
    [self.waitingPlayers removeObjectAtIndex:0];
    [self.waitingPlayers addObject:tempPlayer];
}

-(NSMutableArray *)determineMutualAnimals {
    NSMutableArray *mutualAnimals = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.waitingPlayers count]; i++) {
        NSMutableArray *mutualAnimalsWithPlayerI = [[NSMutableArray alloc] init];
        for (int j = 0; j < 10; j++) {
            if ([[[[self.waitingPlayers objectAtIndex:i] animalCards] objectAtIndex:j] integerValue] == 1 &&
                [[[self.currentPlayer animalCards] objectAtIndex:j] integerValue] > 0) {
                [mutualAnimalsWithPlayerI addObject:[[NSArray alloc] initWithObjects:[self.deck.animals objectAtIndex:j], [NSNumber numberWithInt:1], nil]];
            }
            else if ([[[[self.waitingPlayers objectAtIndex:i] animalCards] objectAtIndex:j] integerValue] == 2 &&
                     [[[self.currentPlayer animalCards] objectAtIndex:j] integerValue] >= 2) {
                [mutualAnimalsWithPlayerI addObject:[[NSArray alloc] initWithObjects:[self.deck.animals objectAtIndex:j], [NSNumber numberWithInt:2], nil]];
            }
        }
        if ([mutualAnimalsWithPlayerI count] > 0) {
            [mutualAnimalsWithPlayerI addObject:[self.waitingPlayers objectAtIndex:i]];
            [mutualAnimals addObject:mutualAnimalsWithPlayerI];
        }
    }
    return mutualAnimals;
}

- (XYZPlayer *)trade {
    
    for (int i = 0; i < 6; i++) {
        self.currentPlayer.moneyCards[i] = [NSNumber numberWithInt:[self.currentPlayer.moneyCards[i] integerValue] + [[[self.tradeBids objectAtIndex:1] objectAtIndex:i] integerValue]];
        self.tradeEnemy.moneyCards[i] = [NSNumber numberWithInt:[self.tradeEnemy.moneyCards[i] integerValue] + [[[self.tradeBids objectAtIndex:0] objectAtIndex:i] integerValue]];
    }
    
    int animalIndex = [[self.deck.animalDict objectForKey:self.animalForTrade] integerValue];
    
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
