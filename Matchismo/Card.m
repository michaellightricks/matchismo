//
//  Card.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (instancetype) initWithOther:(Card *)card {
  self = [super init];
  
  if (self) {
    self.contents = card.contents;
    self.chosen = card.isChosen;
    self.matched = card.isMatched;
  }
  
  return self;
}

- (Card *) clone {
  
  Card * result = [[Card alloc] initWithOther:self];
  
  return result;
}

@end
