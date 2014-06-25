//
//  XYZCard.m
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZCard.h"

@implementation XYZCard


- (id) initWithValue:(NSInteger)value Animal:(NSString *)animal {
	if(self = [super init]) {
		self.value = value;
		self.animal = animal;
	}
	return self;
}

@end
