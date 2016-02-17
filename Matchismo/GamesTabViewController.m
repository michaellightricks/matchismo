// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "GamesTabViewController.h"
#import "MatchingGameViewController.h"
#import "GameHistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation GamesTabViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  if ([segue.identifier isEqualToString:@"GoToGameHistory"]) {
    if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
      GameHistoryViewController *historyController = (GameHistoryViewController *)segue.destinationViewController;
      
      MatchingGameViewController *currentGameVC = (MatchingGameViewController *)self.selectedViewController;
      
      historyController.turns = currentGameVC.game.turns;
      historyController.turnTitleProvider = currentGameVC;
    }
  }
}

@end

NS_ASSUME_NONNULL_END
