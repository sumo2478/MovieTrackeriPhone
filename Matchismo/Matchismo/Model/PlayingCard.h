//
//  PlayingCard.h
//  Matchismo
//
//  Created by user on 13/12/18.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
