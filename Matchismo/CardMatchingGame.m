//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "CardMatchingGame.h"
#import "MinMaxMatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation GameTurn

@end

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) id <MatchingStrategy> matchingStrategy;

@end

@implementation CardMatchingGame

static const int COST_TO_CHOSE = 1;

- (NSMutableArray *)turns {
  if (!_turns) {
    _turns = [[NSMutableArray alloc] init];
  }
  
  return _turns;
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  
  return _cards;
}

- (id <MatchingStrategy>)matchingStrategy {
  if (!_matchingStrategy) {
    _matchingStrategy = [self createMatchingStrategy];
  }
  return _matchingStrategy;
}

- (instancetype)initWithCardCount:(NSUInteger)count {
  self = [super init];
  
  if (self) {
   
    _started = NO;
    Deck *deck = [self createDeck];
    for (int i = 0; i < count; ++i) {
      Card *card = [deck drawRandomCard];
      if (card)  {
        card.index = i;
        [self.cards addObject:card];
        NSLog(@"%@", card.contents);
      }
      else {
        self = nil;
        break;
      }
    }
  }
  
  return self;
}

- (Deck *)createDeck {
  assert(0);
  return nil;
}

-(id <MatchingStrategy>)createMatchingStrategy {
  assert(0);
  return nil;
}

- (GameTurn *)chooseCardAtIndex:(NSUInteger)index {
  _started = YES;
  Card *card = [self cardAtIndex:index];
  
  if (card.isMatched || card.isChosen) {
    return nil;
  }

  GameTurn* turn = [[GameTurn alloc] init];
  turn.chosenCards = [[NSMutableArray alloc] init];
  
  for (Card *c in self.cards) {
    if (c.isChosen && !c.isMatched) {
      [turn.chosenCards addObject:c];
    }
  }
  
  card.chosen = YES;
  
  turn.scoreDelta = [self.matchingStrategy matchCard:card withOtherCards:turn.chosenCards];
  turn.scoreDelta -= COST_TO_CHOSE;

  self.score += turn.scoreDelta;
  turn.score = self.score;
  
  [turn.chosenCards addObject:card];

  if (turn.scoreDelta > 0) {
    [self handleMatchTurn:turn];
  }
  
  // clone cards for history
  for (int i = 0; i < [turn.chosenCards count]; ++i) {
    turn.chosenCards[i] = [turn.chosenCards[i] clone];
  }
  
  [self.turns addObject:turn];
  
  return turn;
}

- (void)handleMatchTurn:(GameTurn *)turn {
  turn.match = true;
  for (Card *card in turn.chosenCards) {
    [self.cards removeObject:card];
  }
  
  int idx = 0;
  for (Card *card in self.cards) {
    card.index = idx++;
  }
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end

NS_ASSUME_NONNULL_END
