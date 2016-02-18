//
//  TwoMinMatchingStrategy.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "MinMaxMatchingStrategy.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MinMaxMatchingStrategy

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (instancetype) initWithMin:(NSUInteger) minCardsToMatch max:(NSUInteger) maxCardsToMatch {
  self = [super init];
  if (self)
  {
    _minCardsNumberToMatch = minCardsToMatch;
    _maxCardsNumberToMatch = maxCardsToMatch;
  }
  
  return self;
}

- (NSInteger)matchCard:(Card *)card withOtherCards:(NSArray *)otherCards {

  NSInteger scoreDelta = 0;

  NSMutableArray* cards = [[NSMutableArray alloc] init];
                           
  [cards addObjectsFromArray:otherCards];
  [cards addObject:card];
  
  card.chosen = YES;
  if ([cards count] != (self.maxCardsNumberToMatch)) {
    return scoreDelta;
  }

  int matchedCount = 0;
  for (int i = 0; i < [cards count] - 1; ++i) {
    for (int j = i + 1; j < [cards count]; ++j) {
      NSInteger matchScore = [self matchCard:cards[i] withOther:cards[j]];
      
      if (matchScore) {
        scoreDelta += (matchScore * MATCH_BONUS);
        ++matchedCount;
      }
    }
  }
  
  if (matchedCount >= self.minCardsNumberToMatch-1) {
    for (Card *c in cards) {
      c.matched = YES;
    }
  }
  else {
    scoreDelta -= MISMATCH_PENALTY;
    for (Card *c in cards) {
      if (c != card) {
        c.chosen = NO;
      }
    }
  }
  
  return scoreDelta;
}

- (NSInteger)matchCard:(PlayingCard *)card withOther:(PlayingCard *)other {
  int score = 0;
  
  if (other.rank == card.rank) {
    score += 4;
  }
  else if ([other.suite isEqualToString:card.suite]) {
    score += 1;
  }
  
  return score;

}

@end
   
NS_ASSUME_NONNULL_END
