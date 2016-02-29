//
//  ViewController.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "CardView.h"
#import "SetMatchingGame.h"
#import "CardView.h"
#import "AnimationQueue.h"
#import "AnimationQueueItem.h"

@interface MatchingGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic) BOOL started;

@end

@implementation MatchingGameViewController

- (void)initCards {
  for (int i = 0; i < self.initialCardsNumber ; ++i) {
    Card* card = [self.game cardAtIndex:i];
    [self addCardView:card withIndex:i];
  }
}

- (CardView *)addCardView:(Card *)card withIndex:(NSInteger)index{
  CardView *cardView = [self createCardView:card];
  cardView.tag = index;
  
  [self.cardsGridVC addCardView:cardView];
  
  return cardView;
}

- (CardView *)createCardView:(Card *)card {
  assert(0);
  return nil;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (!self.started) {
    self.started = true;
    [self.cardsGridVC dealCards];
  }
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"CardsGridSegue"]) {
    self.cardsGridVC = (CardsGridViewController *)segue.destinationViewController;
    self.cardsGridVC.minCellsNumber = self.initialCardsNumber;
    self.cardsGridVC.animationQueue = self.animationQueue;

    __weak MatchingGameViewController *weakSelf = self;
    self.cardsGridVC.onTouchCard = ^(CardView *cardView) {[weakSelf touchCard:cardView];};
    
    [self initCards];
  }
}

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [self createGame:self.initialCardsNumber];
  }
  
  return _game;
}

- (CardMatchingGame *)createGame:(NSUInteger)cardsCount {
  assert(0);
  return nil;
}

- (IBAction)touchNew:(UIButton *)sender {
  [self resetGame];
  [self updateUI];
}

- (void)resetGame {
  _game = nil;
  
  [self.cardsGridVC clear];
  [self initCards];
}

- (IBAction)touchCard:(CardView *)sender {
  GameTurn *turn = [self.game chooseCardAtIndex:sender.tag];
  
  // TODO: remove the assumption on sepcific order
  for (Card *card in [turn.chosenCards reverseObjectEnumerator]) {
    [self onCardChanged:card];
  }
  
  if (turn.match) {
    NSMutableArray *indicesToRemove = [[NSMutableArray alloc] init];
    for (Card * card in turn.chosenCards) {
      [indicesToRemove addObject:[[NSNumber alloc] initWithUnsignedLong:card.index]];
    }
    
    [self.cardsGridVC removeCardViews:indicesToRemove];
  }
  
  [self updateUI];
}

- (void)updateUI {
  self.descLabel.attributedText = [self getTurnStatus:self.game.turns.lastObject];
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
}

- (NSAttributedString*) getTurnStatus:(GameTurn *) turn {
  if (!turn) {
    return [[NSMutableAttributedString alloc] initWithString:@"New game"];
  }
  
  NSMutableAttributedString* result = [[NSMutableAttributedString alloc] init];
  
  bool isMatched = false;
  
  for (Card *card in turn.chosenCards) {
    [result appendAttributedString:[self getTitleForCard:card]];
    isMatched = isMatched || card.isMatched;
  }
  
  NSString* scoreString =
    (isMatched) ? [NSString stringWithFormat:@"are match added %ld points", (long)turn.scoreDelta]
                : [NSString stringWithFormat:@"penalty %ld points", (long)turn.scoreDelta];
  
  [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:scoreString]];
  
  return result;
}

- (NSAttributedString *)getTitleForCard:(Card *)card {
  return [[NSAttributedString alloc] initWithString:( card.isChosen ? card.contents : @"")];
}

- (UIImage *)getImageForCard:(Card *)card {
  assert(0);
  return nil;
}

- (AnimationQueue *)animationQueue {
  if (!_animationQueue) {
    _animationQueue = [[AnimationQueue alloc] init];
  }
  
  return _animationQueue;
}

- (void)onCardChanged:(Card *)card {
  assert(0);
}

@end
