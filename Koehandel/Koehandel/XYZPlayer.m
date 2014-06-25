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
        self.name = name;
        self.moneyCards = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4],[NSNumber numberWithInt:1], nil];
        self.animalCards = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++){
            [self.moneyCards addObject:[NSNumber numberWithInt:0]];
        }
        for (int i = 0; i < 10; i++){
            [self.animalCards addObject:[NSNumber numberWithInt:2]];
        }
    }
    return self;
}

-(NSInteger)getTotalMoney {
    return 10 * [self.moneyCards[1] integerValue] + 50 * [self.moneyCards[2] integerValue] + 100 * [self.moneyCards[3] integerValue] + 200 * [self.moneyCards[4] integerValue] + 500 * [self.moneyCards[5] integerValue];
}

-(NSInteger)getScore {
    NSInteger sets = 0;
    NSInteger values[10] = {10, 40, 90, 160, 250, 350, 500, 650, 800, 1000};
    NSInteger scoreBeforeMultiply;
    for (int i = 0; i < 10; i++) {
        if ([self.animalCards[i] integerValue] == 4) {
            sets++;
            scoreBeforeMultiply += values[i];
        }
    }
    return sets * scoreBeforeMultiply;
}

@end
