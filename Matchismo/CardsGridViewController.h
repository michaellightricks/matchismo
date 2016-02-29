// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AnimationQueue.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^touchCardBlock)(CardView *cardView);

/// Object that controls the behaviour and animation
/// of card views in the grid
@interface CardsGridViewController : UIViewController

/// adds card view to the grid
- (void)addCardView:(CardView *)cardView;

/// removes array of cards from the grid
- (void)removeCardViews:(NSArray *)indicies;

/// performs deal animation for all the card in the grid
- (void)dealCards;

/// clears the grid from cards
- (void)clear;

/// updates indicies of the card views
- (void)updateIndices;

/// returns the card view by index
- (CardView *)getCardViewAt:(NSUInteger)index;

/// minimum cell number for grid layout
@property (nonatomic) NSUInteger minCellsNumber;

/// queue for performing animation in serial manner
@property (strong, nonatomic) AnimationQueue *animationQueue;

/// callback that is called when card view is tapped
@property (nonatomic, copy) touchCardBlock onTouchCard;

@end

NS_ASSUME_NONNULL_END
