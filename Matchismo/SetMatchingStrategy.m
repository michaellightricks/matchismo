// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "SetMatchingStrategy.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct cardMatchStatisticsType {
  int equalsCount;
  int equalsMax;
  bool match;
} cardMatchStatistics;


@implementation SetMatchingStrategy

- (NSInteger)matchCards:(NSArray *)cards {

  // we will count card properties that are equal
  // if at the end max count for each property is _cards_count_ or 0
  // we have set (_cards_count_ all cards are equal 0 are different)
  
  NSInteger scoreDelta = 0;
  
  if ([cards count] == 3) {
    
    cardMatchStatistics stats[4];
    
    for (int i = 0; i < 4; ++i) {
      stats[i].equalsCount = stats[i].equalsMax = 0;
    }
    
    for (int i = 0; i < [cards count]-1; ++i) {
      SetCard *card = (SetCard *)cards[i];
      
      for (int j = i + 1; j < [cards count]; ++j) {
        SetCard *other = (SetCard *)cards[j];

        stats[0].equalsCount += (card.rank == other.rank);
        stats[1].equalsCount += (card.shading == other.shading);
        stats[2].equalsCount += ([card.symbol isEqualToString:other.symbol]);
        stats[3].equalsCount += (card.color == other.color);
      }
      
      for (int k = 0; k < 4; ++k) {
        stats[k].equalsMax = MAX(stats[k].equalsMax, stats[k].equalsCount);
        stats[k].equalsCount = 0;
      }
    }
    
    BOOL set = YES;
  
    for (int k = 0; k < 4 && set; ++k) {
      set = set && ((stats[k].equalsMax == [cards count]-1) || stats[k].equalsMax == 0);
    }
    
    if (set) {
      scoreDelta += 4;
      for (Card* card in cards) {
        card.matched = YES;
      }
    }
    else {
      scoreDelta -= 2;
      for (Card* card in cards) {
        card.chosen = NO;
      }

    }
    
  }
  
  return scoreDelta;
}

@end

NS_ASSUME_NONNULL_END
