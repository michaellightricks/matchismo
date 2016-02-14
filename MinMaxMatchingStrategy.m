//
//  TwoMinMatchingStrategy.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "MinMaxMatchingStrategy.h"

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

- (NSInteger)matchCard:(Card *) card withOthers:(NSArray *)otherCards returnInvolved:(NSMutableArray *) involved{
  
  NSMutableArray* choosenCards = [[NSMutableArray alloc] init];
  NSInteger scoreDelta = 0;
  for (Card *other in otherCards) {
    if (other.isChosen && !other.isMatched) {
      [choosenCards addObject:other];
    }
  }
  
  if ([choosenCards count] == (self.maxCardsNumberToMatch-1))
  {
    NSMutableArray* matchedCards = [[NSMutableArray alloc] init];
    for (Card *otherChoosen in choosenCards) {
      int matchScore = [card match:@[otherChoosen]];
      if (matchScore) {
        scoreDelta += (matchScore * MATCH_BONUS);
        [matchedCards addObject:otherChoosen];
      }
      else {
        scoreDelta -= MISMATCH_PENALTY;
      }
    }
    
    if ([matchedCards count] >= (self.minCardsNumberToMatch-1)) {
      for (Card *otherChoosen in choosenCards) {
        otherChoosen.matched = YES;
      }
      card.matched = YES;
    }
    else {
      for (Card *otherChoosen in choosenCards) {
        otherChoosen.chosen = NO;
      }
    }
  }

  for (Card* choosen in choosenCards) {
    [involved addObject:[choosen clone]];
  }
  
  [involved addObject:[card clone]];
  
  return scoreDelta;
}

@end
