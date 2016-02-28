// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CardView.h"
#import "AnimationQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsGridViewController : UIViewController

- (void)addCardView:(CardView *)cardView;
- (void)removeCardViews:(NSArray *)indicies;
- (void)dealCards;
- (void)clear;
- (void)updateIndices;

- (CardView *)getCardViewAt:(NSUInteger)index;

@property (nonatomic) NSUInteger minCellsNumber;

@property (nonatomic) AnimationQueue *animationQueue;

@end

NS_ASSUME_NONNULL_END
