//
//  XYZDeck.h
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZCard.h"

@interface XYZDeck : NSObject

@property NSMutableArray *cards;
@property NSMutableArray *animals;
@property NSMutableDictionary *animalDict;

- (void) shuffle;
- (XYZCard *) draw;

@end
