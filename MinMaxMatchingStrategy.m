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

- (NSInteger)matchCard:(Card *) card withOthers:(NSArray *)otherCards {
  
  NSMutableArray
  NSInteger scoreDelta = 0;
  for (Card* other in otherCards) {
    if (other.isChosen && !other.isMatched) {
      int matchScore = [card match:@[other]];
      if (matchScore) {
        scoreDelta += (matchScore * MATCH_BONUS);
        other.matched = card.matched = YES;
      }
      else {
        self.score -= MISMATCH_PENALTY;
        other.chosen = NO;
      }
      break;
    }
  }

}

@end
