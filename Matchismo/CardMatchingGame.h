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

NS_ASSUME_NONNULL_BEGIN

typedef void(^cardsCollectionBlock)(NSArray *cardsIndicies);
typedef void(^singleCardBlock)(NSUInteger cardIndex);

@interface GameTurn : NSObject

@property (strong, nonatomic) NSMutableArray* chosenCards;
@property (nonatomic) NSInteger scoreDelta;
@property (nonatomic) NSInteger score;

@property (nonatomic) BOOL match;

@end

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count;
- (GameTurn *)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// protected abstract start
- (Deck *)createDeck;
- (id <MatchingStrategy>)createMatchingStrategy;
// protected abstract end

@property (readonly, nonatomic) BOOL started;
@property (readonly, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray* turns;
@property (nonatomic) Deck * deck;
@property (nonatomic) NSMutableArray *cards;

@end

NS_ASSUME_NONNULL_END
