// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "PlayingCardsMatchingGameVC.h"
#import "PlayingCardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardsMatchingGameVC()

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSwitch;

@end

@implementation PlayingCardsMatchingGameVC

static const int MAX_MATCH_NUMBERS[] = {2, 3};

- (NSUInteger)cardsNumber {
  return 30;
}

- (IBAction)matchMaxValueChanged:(id)sender {
  PlayingCardMatchingGame *myGame = (PlayingCardMatchingGame *)self.game;
  myGame.maxMatchCount = MAX_MATCH_NUMBERS[self.matchSwitch.selectedSegmentIndex];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self matchMaxValueChanged:self.matchSwitch];
}

- (CardMatchingGame *)createGame:(NSUInteger)cardsCount {
  return [[PlayingCardMatchingGame alloc] initWithCardCount:cardsCount];
}

- (void)updateUI {
  [super updateUI];
  self.matchSwitch.enabled = !self.game.started;
}

- (UIImage *)getImageForCard:(Card *)card {
  return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (CardView *)createCardView:(Card *)card {
  PlayingCard *playingCard = (PlayingCard *)card;
  
  PlayingCardView *result = [[PlayingCardView alloc] init];
  result.rank = playingCard.rank;
  result.suite = playingCard.suite;
  
  return result;
}

- (void)onCardChanged:(NSUInteger)cardIndex {
  
  PlayingCardView *cardView = (PlayingCardView *)[self.cardsGridVC getCardViewAt:cardIndex];
  PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardIndex];
  
  if (card.isChosen == cardView.faceUp) {
    return;
  }

  AnimationQueueItemTransition *transition = [[AnimationQueueItemTransition alloc] init];
  transition.view = cardView;
  transition.duration = 0.2;
  transition.beforeAnimation = nil;
  transition.animation = ^{cardView.faceUp = card.isChosen;};
  transition.completion = nil;
  
  [self.animationQueue addAnimation:transition];
  
}

@end

NS_ASSUME_NONNULL_END
