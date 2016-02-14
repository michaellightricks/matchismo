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
@property (nonatomic, strong) id <MatchingStrategy> matchingStrategy;
@property NSMutableArray* turns;
@end

@implementation CardMatchingGame

static const int COST_TO_CHOSE = 1;

- (NSMutableArray *) turns {
  if (!_turns) {
    _turns = [[NSMutableArray alloc] init];
  }
  
  return _turns;
}

- (NSMutableArray *) cards
{
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *) deck
                 andMatchStrategy:(id <MatchingStrategy>) strategy {
  self = [super init];
  
  if (self) {
    _started = NO;
    _matchingStrategy = strategy;
    _status = @"New game";
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

- (void)chooseCardAtIndex:(NSUInteger)index
{
  _started = YES;
  Card *card = [self cardAtIndex:index];
  
  GameTurn* turn = [[GameTurn alloc] init];
  
  if (!card.isMatched) {
    if (!card.isChosen) {
      
      NSMutableArray *involved = [[NSMutableArray alloc] init];
      
      GameTurn *turn = [[GameTurn alloc] init];

      self.score += [self.matchingStrategy matchCard:card withOthers:self.cards returnInvolved:involved];
      
      for (Card *involvedCard in involved) {
        [turn.choosenCards addObject:[involvedCard clone]];
      }
      
      [self.turns addObject:turn];
      [self updateStatus:turn];
      
      self.score -= COST_TO_CHOSE;
      card.chosen = YES;
    }
  }
}

- (void)updateStatus:(GameTurn *) turn {
  
  NSString* cardsString = [[NSString alloc] init];
  
  bool isMatched = false;
  
  for (Card *card in turn.choosenCards) {
    cardsString = [NSString stringWithFormat:@"%@%@ ", cardsString, card.contents];
    isMatched = isMatched || card.isMatched;
  }
 
  if (isMatched) {
    self.status = [NSString stringWithFormat:@"%@are match", cardsString];
  }
  else {
    self.status = cardsString;
  }
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
