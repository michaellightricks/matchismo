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

NS_ASSUME_NONNULL_BEGIN

// Object that provides the title for the specific game turn
@protocol TurnStatusProvider <NSObject>

- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

@end

/// Object that implements general game controller logic
/// should be subclassed for each specific game type
@interface MatchingGameViewController : UIViewController <TurnStatusProvider>

/// abstract function that shoudl create new game with \c cardsCount
- (CardMatchingGame *)createGame:(NSUInteger)cardsCount;

/// abstract function that creates cardView appropriate for specific card type
- (CardView *)createCardView:(Card *)card;

// protected function that adds new card view to internal collection
- (CardView *)addCardView:(Card *)card withIndex:(NSInteger)index;

/// protected function that updates general UI elements (turn title, score, etc)
- (void)updateUI;

/// protected abstarct function returning the title for specific card
- (NSAttributedString *)getTitleForCard:(Card *)card;

/// protected abstarct function returning the image for specific card
- (UIImage *)getImageForCard:(Card *)card;

/// protected abstarct function returning the turn status description
- (NSAttributedString*)getTurnStatus:(GameTurn *) turn;

/// protected abstract function that should update ui on card change
- (void)onCardChanged:(Card *)card;

/// Number of cards the game will start with
@property (nonatomic) NSUInteger initialCardsNumber;

/// View controller dealing with card layout and animation
@property (strong, nonatomic) CardsGridViewController* cardsGridVC;

/// Queue of scheduled animation that provides
/// simple serial animation execution and cancelling
@property (strong, nonatomic) AnimationQueue *animationQueue;

/// Current game instance
@property (strong, nonatomic) CardMatchingGame* game;

@end

NS_ASSUME_NONNULL_END
