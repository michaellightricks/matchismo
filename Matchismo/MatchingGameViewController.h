//
//  ViewController.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@protocol TurnTitleProvider <NSObject>

- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

@end

@interface MatchingGameViewController : UIViewController <TurnTitleProvider>

- (CardMatchingGame *)createGame:(NSUInteger)cardsCount;
- (void)updateUI;
- (NSAttributedString *)getTitleForCard:(Card *)card;
- (UIImage *)getImageForCard:(Card *)card;
- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

// abstract protected start
@property (nonatomic) NSUInteger cardsNumber;
// abstract protected end

@property (strong, nonatomic) CardMatchingGame* game;

@end

