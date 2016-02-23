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
#import "CardsGridViewController.h"
#import "CardView.h"

@interface MatchingGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) CardsGridViewController* cardsGridVC;

@end

@implementation MatchingGameViewController

- (void) initCards {
  
  for (int i = 0; i < self.cardsNumber; ++i) {
    Card* card = [self.game cardAtIndex:i];
    
    CardView *cardView = [self createCardView:card];
    [self.cardsGridVC addCardView:cardView];
  }
}

- (CardView *)createCardView:(Card *)card {
  assert(0);
  return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"CardsGridSegue"]) {
    self.cardsGridVC = (CardsGridViewController *)segue.destinationViewController;
    self.cardsGridVC.minCellsNumber = self.cardsNumber;
    [self initCards];
  }
}

- (CardView *)createCardView {
  assert(0);
  return nil;
}

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [self createGame:self.cardsNumber];
  }
  
  return _game;
}

-(CardMatchingGame *)createGame:(NSUInteger)cardsCount {
  assert(0);
  return nil;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchNew:(UIButton *)sender {
  [self resetGame];
  [self updateUI];
}

- (void)resetGame {
  _game = nil;
}

- (IBAction)touchCardbutton:(UIButton *)sender {
  NSUInteger index = 0;//[self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:index];
  [self updateUI];
}

- (void)updateUI
{
//  for (UIButton* btn in self.cardButtons) {
//    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:btn]];
//    [btn setAttributedTitle:[self getTitleForCard:card] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[self getImageForCard:card] forState:UIControlStateNormal];
//
//    btn.enabled = !card.isMatched;
//  }
  
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
    [result appendAttributedString:[self getTitleForCard:card]];//= [NSString stringWithFormat:@"%@%@ ", cardsString, card.contents];
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

@end
