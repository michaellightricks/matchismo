//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "CardMatchingGame.h"
#import "MinMaxMatchingStrategy.h"

@interface GameTurn : NSObject

@property (nonatomic, strong) NSMutableArray* choosenCards;
@property (nonatomic) NSInteger scoreDelta;
@end

@implementation GameTurn

- (NSMutableArray *) choosenCards {
  if (!_choosenCards) {
    _choosenCards = [[NSMutableArray alloc] init];
  }
  
  return _choosenCards;
}

@end

@interface CardMatchingGame()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray* turns;
@property (nonatomic, strong) id <MatchingStrategy> matchingStrategy;

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
    _status = @"New game";
    Deck *deck = [self createDeck];
    for (int i = 0; i < count; ++i) {
      Card *card = [deck drawRandomCard];
      if (card)  {
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

- (void)chooseCardAtIndex:(NSUInteger)index {
  _started = YES;
  Card *card = [self cardAtIndex:index];
  
  if (card.isMatched || card.isChosen) {
    return;
  }

  GameTurn* turn = [[GameTurn alloc] init];
  
  card.chosen = YES;
  
  for (Card * card in self.cards) {
    if (card.isChosen && !card.isMatched) {
      [turn.choosenCards addObject:card];
    }
  }
  
  turn.scoreDelta = [self.matchingStrategy matchCards:turn.choosenCards];
  turn.scoreDelta -= COST_TO_CHOSE;
  
  card.chosen = YES;
  
  self.score += turn.scoreDelta;
  
  [self.turns addObject:turn];
  [self updateStatus:turn];
}

- (void)updateStatus:(GameTurn *) turn {
  
  NSString* cardsString = [[NSString alloc] init];
  
  bool isMatched = false;
  
  for (Card *card in turn.choosenCards) {
    cardsString = [NSString stringWithFormat:@"%@%@ ", cardsString, card.contents];
    isMatched = isMatched || card.isMatched;
  }
 
  if (isMatched) {
    self.status = [NSString stringWithFormat:@"%@are match added %ld points", cardsString, (long)turn.scoreDelta];
  }
  else {
    self.status = [NSString stringWithFormat:@"%@ penalty %ld points", cardsString, (long)turn.scoreDelta];
  }
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
