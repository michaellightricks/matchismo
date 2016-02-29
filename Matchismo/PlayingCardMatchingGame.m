// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "PlayingCardMatchingGame.h"

#import "MinMaxMatchingStrategy.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardMatchingGame

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (id <MatchingStrategy>)createMatchingStrategy {
  return [[MinMaxMatchingStrategy alloc] initWithMin:2 max:self.maxMatchCount];
}

@end

NS_ASSUME_NONNULL_END
