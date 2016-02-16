//
//  SetDeck.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype) init {
  
  self = [super init];
  if (self)
  {
    for (NSUInteger rank = 1; rank <= [SetCard maxRank]; ++rank) {
      for (UIColor* color in [SetCard validColors]) {
        for (NSString* symbol in [SetCard validSymbols]) {
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
