//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@implementation PlayingCardDeck

- (instancetype)init
{
  self = [super init];
  if (self)
  {
    for (NSString *suit in [PlayingCard validSuits])
    {
      //NSLog(@"maxRank %d", [PlayingCard maxRank]);
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; ++rank)
      {
        PlayingCard* card = [[PlayingCard alloc] init];
        card.rank = rank;
        card.suite = suit;
        
        [self addCard:card];
      }
    }
  }
  
  return self;
}

@end
