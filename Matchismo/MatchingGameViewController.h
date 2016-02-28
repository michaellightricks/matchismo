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
- (void)updateUI;
- (NSAttributedString *)getTitleForCard:(Card *)card;
- (UIImage *)getImageForCard:(Card *)card;
- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

// abstract methods start
- (void)onCardChanged:(NSUInteger)cardIndex;
// abstract methods end

// abstract protected start
@property (nonatomic) NSUInteger cardsNumber;
// abstract protected end

// protected start
@property (strong, nonatomic) CardsGridViewController* cardsGridVC;
@property (nonatomic) AnimationQueue *animationQueue;
@property (strong, nonatomic) CardMatchingGame* game;
// protected end


@end

