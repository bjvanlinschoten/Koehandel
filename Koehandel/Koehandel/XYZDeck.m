//
//  XYZDeck.m
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZDeck.h"

@implementation XYZDeck

- (id) init {
	if(self = [super init]) {
        
        // init deck with 4 cards of each animal with corresponding value
		self.cards = [[NSMutableArray alloc] init];
        self.animals = [[NSMutableArray alloc] initWithObjects:@"Chicken", @"Goose", @"Cat", @"Dog", @"Sheep", @"Goat", @"Donkey", @"Pig", @"Cow", @"Horse", nil];
        self.animalDict = [[NSMutableDictionary alloc] init];
        NSInteger values[10] = {10, 40, 90, 160, 250, 350, 500, 650, 800, 1000};
        
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 4; j++) {
                XYZCard *card = [[XYZCard alloc] initWithValue:values[i] Animal:[self.animals objectAtIndex:i]];
                [self.cards addObject:card];
            }
            [self.animalDict setValue:[NSNumber numberWithInt:i] forKey:[self.animals objectAtIndex:i]];
        }
    }
    
    // shuffle the deck
    [self shuffle];
	return self;
}

// random sort for the shuffle
int randomSort(id obj1, id obj2, void *context) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);
}

// shuffle by randomSorting multiple times
- (void) shuffle {
	for(int x = 0; x < 500; x++) {
		[self.cards sortUsingFunction:randomSort context:nil];
	}
}

// draw a card
- (XYZCard *) draw {
    XYZCard *card = [self.cards lastObject];
    [self.cards removeLastObject];
    return card;
}

@end
