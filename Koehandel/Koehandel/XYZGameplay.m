//
//  XYZGameplay.m
//  Koehandel
//
//  Created by Boris van Linschoten on 23-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZGameplay.h"

@implementation XYZGameplay

-(void)auctionCard:(XYZCard *)cardSold soldfor:(int)amount buyer:(XYZPlayer *)buyer {
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
        
        buyer.animalCards[cardSold.animal] = [NSNumber numberWithInt:[buyer.animalCards[cardSold.animal] integerValue] + 1];
    }
}


@end
