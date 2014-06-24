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
		self.cards = [[NSMutableArray alloc] init];
        NSInteger values[10] = {10, 40, 90, 160, 250, 350, 500, 650, 800, 1000};
        Animal animals[10] = {Chicken, Goose, Cat, Dog, Sheep, Goat, Donkey, Pig, Cow, Horse};
        
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 4; j++) {
                XYZCard *card = [[XYZCard alloc] initWithValue:values[i] Animal:animals[i]];
                [self.cards addObject:card];
            }
        }
    }
    [self shuffle];
	return self;
}

int randomSort(id obj1, id obj2, void *context) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);
}

- (void) shuffle {
	for(int x = 0; x < 500; x++) {
		[self.cards sortUsingFunction:randomSort context:nil];
	}
}

- (XYZCard *) draw {
    XYZCard *card = [self.cards lastObject];
    [self.cards removeLastObject];
    return card;
}

@end
