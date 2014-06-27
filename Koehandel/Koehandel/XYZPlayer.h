//
//  XYZPlayer.h
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZCard.h"

@interface XYZPlayer : NSObject

@property NSMutableArray *moneyCards;
@property NSMutableArray *animalCards;
@property NSString *name;

-(NSInteger)getTotalMoney;
-(NSInteger)getScore;
-(NSInteger)getAmountMoneyCards;
-(NSInteger)getSets;
-(id) initWithName: (NSString *)name;

@end
