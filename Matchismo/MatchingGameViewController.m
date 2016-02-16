//
//  ViewController.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "MatchingGameViewController.h"

#import "SetMatchingGame.h"

@interface MatchingGameViewController ()

@property (strong, nonatomic) NSMutableArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation MatchingGameViewController

- (void) addButtons {
  
  if (!_cardButtons) {
    _cardButtons = [[NSMutableArray alloc] init];
    int gridWidth = 5;
    int gridHeight = 6;
    int btnWidth = 40;
    int btnHeight = 60;
    
    int startX = (self.view.frame.size.width - btnWidth * 5) / 2;
    int startY = self.btnNew.frame.size.height;
    
    for (int i = 0; i < gridWidth; ++i) {
      for (int j = 0; j < gridHeight; ++j) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setFrame:CGRectMake(startX + btnWidth * i, startY + btnHeight * j, btnWidth, btnHeight)];
        
        [btn addTarget:self action:@selector(touchCardbutton:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        [self.cardButtons addObject:btn];
      }
    }
  }

}

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [self createGame:[self.cardButtons count]];//[[SetMatchingGame alloc] initWithCardCount:[self.cardButtons count]];
  }
  
  return _game;
}

-(CardMatchingGame *)createGame:(NSUInteger)cardsCount {
  assert(0);
  return nil;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self addButtons];
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
  NSUInteger index = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:index];
  [self updateUI];
}

- (void)updateUI
{
  for (UIButton* btn in self.cardButtons) {
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:btn]];
    [btn setAttributedTitle:[self getTitleForCard:card] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self getImageForCard:card] forState:UIControlStateNormal];

    btn.enabled = !card.isMatched;
  }

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
