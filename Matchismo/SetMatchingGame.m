// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "SetMatchingGame.h"
#import "SetDeck.h"
#import "SetMatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

#define NUMBER_OF_NEW_CARDS 3

@implementation SetMatchingGame

- (Deck *)createDeck {
  return [[SetDeck alloc] init];
}

- (id <MatchingStrategy>)createMatchingStrategy {
  return [[SetMatchingStrategy alloc] init];
}

- (NSArray *)addNewSet {
  NSUInteger cardsCount = [self.cards count];
  
  NSMutableArray *newCards = [[NSMutableArray alloc] init];
  for (int i = 0; i < NUMBER_OF_NEW_CARDS; ++i) {
    Card *card = [self.deck drawRandomCard];
    card.index = cardsCount + i;
    [self.cards addObject:card];
    [newCards addObject:card];
  }
  
  return newCards;
}

@end

NS_ASSUME_NONNULL_END
