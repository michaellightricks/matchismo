//
//  Deck.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()

@property (nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards {
  if (!_cards){
    _cards = [[NSMutableArray alloc] init];
  }
  
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }
  else{
    [self.cards addObject:card];
  }
}

-(void) addCard:(Card *)card {
  [self addCard:card atTop:NO];
}

-(Card *) drawRandomCard {
  Card* result = NULL;

  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    result  = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
  return result;
}

@end

NS_ASSUME_NONNULL_END