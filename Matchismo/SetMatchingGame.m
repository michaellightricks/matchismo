// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "SetMatchingGame.h"
#import "SetDeck.h"
#import "SetMatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetMatchingGame

- (Deck *)createDeck {
  return [[SetDeck alloc] init];
}

- (id <MatchingStrategy>)createMatchingStrategy {
  return [[SetMatchingStrategy alloc] init];
}


@end

NS_ASSUME_NONNULL_END
