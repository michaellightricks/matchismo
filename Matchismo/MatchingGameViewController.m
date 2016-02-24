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
    [self addCardView:card];
  }
}

- (CardView *)addCardView:(Card *)card {

  CardView *cardView = [self createCardView:card];
  [cardView addTarget:self action:@selector(touchCardbutton:) forControlEvents:UIControlEventTouchUpInside];
  [self.cardsGridVC addCardView:cardView];

  return cardView;
}

- (CardView *)createCardView:(Card *)card {
  assert(0);
  return nil;
}

- (void)viewDidAppear:(BOOL)animated {

  [super viewDidAppear:animated];
  
  [self.cardsGridVC dealCards];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
  
  [self.cardsGridVC dealCards];
}

- (IBAction)touchCardbutton:(CardView *)sender {
  NSUInteger index = 0;//[self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:index];
  [self updateUI];
}

- (void)updateUI
{
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
