//
//  ViewController.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "MinMaxMatchingStrategy.h"

@interface ViewController ()

//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) NSMutableArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSwitch;
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) id <MatchingStrategy> matchStrategy;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ViewController

static const int MAX_MATCH_NUMBERS[] = {2, 3};


- (void) addButtons {
  _cardButtons = [[NSMutableArray alloc] init];
  int gridWidth = 5;
  int gridHeight = 6;
  int btnWidth = 40;
  int btnHeight = 60;
  
  int startX = 100;//self.btnNew.frame.origin.x;
  int startY = 100;//self.btnNew.frame.origin.y + 1.5 * self.btnNew.frame.size.height;
  
  
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

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:self.deck
                                       andMatchStrategy:self.matchStrategy];
  }
  
  return _game;
}

- (Deck *)deck {
  if (!_deck) {
    _deck = [[PlayingCardDeck alloc] init];
  }
  
  return _deck;
}

- (id <MatchingStrategy>) matchStrategy {
  if (!_matchStrategy) {
    _matchStrategy = [[MinMaxMatchingStrategy alloc] initWithMin:2
                                                             max:MAX_MATCH_NUMBERS[self.matchSwitch.selectedSegmentIndex]];
  }
  
  return _matchStrategy;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  [self addButtons];
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
  _deck = nil;
  _matchStrategy = nil;
}

- (IBAction)touchCardbutton:(UIButton *)sender {
  int index = [self.cardButtons indexOfObject:sender];
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
