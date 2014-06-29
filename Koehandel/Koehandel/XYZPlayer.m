//
//  XYZPlayer.m
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZPlayer.h"

@implementation XYZPlayer

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        
        // init the player with their name, starting money cards and init empty array for animal cards
        self.name = name;
        self.moneyCards = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4],[NSNumber numberWithInt:1], nil];
        self.animalCards = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++){
            [self.moneyCards addObject:[NSNumber numberWithInt:0]];
        }
        for (int i = 0; i < 10; i++){
            [self.animalCards addObject:[NSNumber numberWithInt:0]];
        }
    }
    return self;
}

// get total amount of money of player
-(NSInteger)getTotalMoney {
    return 10 * [self.moneyCards[1] integerValue] + 50 * [self.moneyCards[2] integerValue] + 100 * [self.moneyCards[3] integerValue] + 200 * [self.moneyCards[4] integerValue] + 500 * [self.moneyCards[5] integerValue];
}

// get total score of player (game rule: score = (setvalue1 + setvalue2 + ...) * amount of sets)
-(NSInteger)getScore {
    NSInteger sets = 0;
    NSInteger values[10] = {10, 40, 90, 160, 250, 350, 500, 650, 800, 1000};
    NSInteger scoreBeforeMultiply = 0;
    for (int i = 0; i < 10; i++) {
        if ([self.animalCards[i] integerValue] == 4) {
            sets++;
            scoreBeforeMultiply += values[i];
        }
    }
    return sets * scoreBeforeMultiply;
}

// get total amount of moneycards
-(NSInteger)getAmountMoneyCards {
    int amount = 0;
    for (int i = 0; i < 6; i++) {
        amount += [[self.moneyCards objectAtIndex:i] integerValue];
    }
    return amount;
}

// get total amount of sets
-(NSInteger)getSets {
    int sets = 0;
    for (int i = 0; i < 10; i++) {
        if ([self.animalCards[i] integerValue] == 4) {
            sets++;
        }
    }
    return sets;
}

@end
