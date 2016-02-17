// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "GameHistoryViewController.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameHistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation GameHistoryViewController

-(void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:animated];
  
  if (!self.turns) {
    return;
  }
  
  NSMutableAttributedString* text = [[NSMutableAttributedString alloc] init];
  
  for (GameTurn *turn in self.turns) {
    [text appendAttributedString:[self.turnTitleProvider getTurnStatus:turn]];
    [text appendAttributedString:[[NSAttributedString alloc]
                                  initWithString:[NSString stringWithFormat:@" overall score %ld", (long)turn.score]]];
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  } 
  
  [self.historyTextView setAttributedText:text];
}

@end

NS_ASSUME_NONNULL_END
