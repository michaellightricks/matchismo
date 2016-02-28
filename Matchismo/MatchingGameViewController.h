//
//  ViewController.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "CardView.h"
#import "CardsGridViewController.h"

@protocol TurnTitleProvider <NSObject>

- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

@end

@interface MatchingGameViewController : UIViewController <TurnTitleProvider>

- (CardMatchingGame *)createGame:(NSUInteger)cardsCount;
- (CardView *)createCardView:(Card *)card;
- (CardView *)addCardView:(Card *)card withIndex:(NSInteger)index;
- (void)updateUI;
- (NSAttributedString *)getTitleForCard:(Card *)card;
- (UIImage *)getImageForCard:(Card *)card;
- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;
- (void)onCardChanged:(Card *)card;

@property (nonatomic) NSUInteger initialCardsNumber;
@property (strong, nonatomic) CardsGridViewController* cardsGridVC;
@property (nonatomic) AnimationQueue *animationQueue;
@property (strong, nonatomic) CardMatchingGame* game;


@end

