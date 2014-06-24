//
//  XYZCard.h
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Chicken,
    Goose,
    Cat,
    Dog,
    Sheep,
    Goat,
    Donkey,
    Pig,
    Cow,
    Horse
} Animal;

@interface XYZCard : NSObject

@property Animal animal;
@property NSInteger value;

-(id) initWithValue:(NSInteger) aValue Animal:(Animal) aAnimal;
@end
