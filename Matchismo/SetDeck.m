//
//  SetDeck.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetDeck

- (instancetype) init {
  
  self = [super init];
  if (self)
  {
    for (NSUInteger rank = 1; rank <= [SetCard maxRank]; ++rank) {
      for (SetCardColor color = 0; color < COLORS_MAX; ++color) {
        for (SetCardSymbol symbol = 0; symbol < SYMBOL_MAX; ++symbol) {
          for (SetCardShading shading = 0; shading < SHADING_MAX; ++shading) {
            SetCard* card = [[SetCard alloc] init];
            card.rank = rank;
            card.symbol = symbol;
            card.shading = shading;
            card.color = color;
            
            [self addCard:card];
          }
        }
      }
    }
  }
  
  return self;
}

@end

NS_ASSUME_NONNULL_END
