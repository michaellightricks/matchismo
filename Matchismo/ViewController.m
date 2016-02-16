//
//  ViewController.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardMatchingGame.h"
#import "SetMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSwitch;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchCountSwitch;

@end

@implementation ViewController

static const int MAX_MATCH_NUMBERS[] = {2, 3};

- (IBAction)matchMaxValueChanged:(id)sender {

  self.game.maxMatchCount = MAX_MATCH_NUMBERS[self.matchSwitch.selectedSegmentIndex];
}

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
    //_game = [[PlayingCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]];
    _game = [[SetMatchingGame alloc] initWithCardCount:[self.cardButtons count]];
  }
  
  return _game;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self addButtons];
  [self matchMaxValueChanged:self.matchCountSwitch];
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
    
    [btn setTitle:[self getTitleForCard:card] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self getImageForCard:card] forState:UIControlStateNormal];
    
    btn.enabled = !card.isMatched;
    self.descLabel.text = self.game.status;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
  }
  
  self.matchSwitch.enabled = !self.game.started;
}

- (NSString *)getTitleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)getImageForCard:(Card *)card {
  return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

@end
