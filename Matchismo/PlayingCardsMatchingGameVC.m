// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "PlayingCardsMatchingGameVC.h"
#import "PlayingCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardsMatchingGameVC()

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSwitch;

@end

@implementation PlayingCardsMatchingGameVC

static const int MAX_MATCH_NUMBERS[] = {2, 3};

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

@end

NS_ASSUME_NONNULL_END
