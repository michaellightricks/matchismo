//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "MatchingStrategy.h"

@interface GameTurn : NSObject

@property (strong, nonatomic) NSMutableArray* chosenCards;
@property (nonatomic) NSInteger scoreDelta;
@property (nonatomic) NSInteger score;

@end

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// protected abstract start

- (Deck *)createDeck;
- (id <MatchingStrategy>)createMatchingStrategy;

// protected abstract end

@property (readonly, nonatomic) BOOL started;
@property (readonly, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray* turns;

@end
