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

/// Object that implements game turn
@interface GameTurn : NSObject

/// collection of the cards that are chosen at this turn
@property (strong, nonatomic) NSMutableArray* chosenCards;

/// amount of score points that are given or removed from overall score
/// as the result of the turn
@property (nonatomic) NSInteger scoreDelta;

/// overalll game score at the end of this turn
@property (nonatomic) NSInteger score;

/// match status of the this turn
@property (nonatomic) BOOL match;

@end


/// Object that implements base class for generic card matching game
@interface CardMatchingGame : NSObject

/// initializes the game with cards count
- (instancetype)initWithCardCount:(NSUInteger)count;

/// performs basic matching game turn by chosing a card at specific index
- (GameTurn *)chooseCardAtIndex:(NSUInteger)index;

/// returns the card at the specified index
- (Card *)cardAtIndex:(NSUInteger)index;

/// protected abstract method that should create new card deck
- (Deck *)createDeck;

/// protected abstract method that should create new matching strategy
- (id <MatchingStrategy>)createMatchingStrategy;

@property (readonly, nonatomic) BOOL started;

/// overall game score at current moment
@property (readonly, nonatomic) NSInteger score;

/// collection of all the turns performed during the game so far
@property (strong, nonatomic) NSMutableArray* turns;

/// card deck used with the game
@property (nonatomic) Deck * deck;

/// collection of cards for the game
@property (nonatomic) NSMutableArray *cards;

@end

NS_ASSUME_NONNULL_END
