// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "CardsGridViewController.h"

#import "PlayingCardView.h"
#import "Grid.h"
#import "AnimationQueue.h"


NS_ASSUME_NONNULL_BEGIN

@interface CardsGridViewController()

@property (nonatomic) NSMutableArray *cardViewsArray;

@property (nonatomic) Grid *grid;

@property (nonatomic) CGRect cardViewSourceFrame;

@property (nonatomic) AnimationQueue *animationQueue;

@property (nonatomic) NSMutableSet *animatedViews;

@end

@implementation CardsGridViewController

#define ITEM_MARGIN_SIZE (2)

- (NSMutableSet *)animatedViews {
  if (!_animatedViews) {
    _animatedViews = [[NSMutableSet alloc] init];
  }
  
  return _animatedViews;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  self.view.backgroundColor = [UIColor clearColor];
  
  self.grid = [[Grid alloc] init];
  self.grid.size = self.view.bounds.size;
  self.grid.minimumNumberOfCells = self.minCellsNumber;
  self.grid.cellAspectRatio = 2.0 / 3.0;
  
  [self updateViews];
}

- (void)addCardView:(CardView *)cardView {
  [self.cardViewsArray addObject:cardView];
  [self.view addSubview:cardView];
  
  if (_grid) {
    [self addDealAnimationForCard:[self.cardViewsArray count] - 1];
  }
}

- (CGRect)getFrameForCardIndex:(NSUInteger)index {
  
  return [self getFrameForCardIndex:index byGrid:self.grid];

}

- (CGRect)getFrameForCardIndex:(NSUInteger)index byGrid:(Grid *)grid{
  NSUInteger row = index / self.grid.columnCount;
  NSUInteger colum = index % self.grid.columnCount;
  
  return CGRectInset([grid frameOfCellAtRow:row inColumn:colum], ITEM_MARGIN_SIZE, ITEM_MARGIN_SIZE);
}

- (void)sendCardView:(CardView *)cardView from:(CGRect)source to:(CGRect)destination completion:(void(^)(BOOL finished))completion{
  [cardView setFrame:source];
  [UIView animateWithDuration:0.2 animations:^ {cardView.frame = destination;} completion:completion];
}

- (void)removeCardView:(CardView *)cardView {
  [self.cardViewsArray removeObject:cardView];

  [cardView removeFromSuperview];
  [self updateViews];
}

- (void)updateViews {
  if (!_grid)
    return;
  
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {

    CardView *cardView = self.cardViewsArray[i];
    if ([self.animatedViews containsObject:cardView]) {
      [cardView setFrame:[self getFrameForCardIndex:i]];
    }
  }
}

- (NSMutableArray *)cardViewsArray {
  if (!_cardViewsArray) {
    _cardViewsArray = [[NSMutableArray alloc] init];
  }
  
  return _cardViewsArray;
}

- (void)dealCards {

  [self.animationQueue clearAnimations];
  [self.animatedViews removeAllObjects];
  
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {
    [self addDealAnimationForCard:i];
  }
}

- (void)addDealAnimationForCard:(NSUInteger)index {

  __weak CardsGridViewController *weakSelf = self;
  
  CardView *cardView = self.cardViewsArray[index];
  [cardView setFrame:self.cardViewSourceFrame];
  
  AnimationQueueItem *item = [[AnimationQueueItem alloc] init];
  item.duration = 0.2;
  item.beforeAnimation = ^{[weakSelf.animatedViews addObject:cardView];};
  item.animation = ^{cardView.frame = [weakSelf getFrameForCardIndex:index];};
  item.completion = nil;

  [self.animationQueue addAnimation:item];
  
}

- (AnimationQueue *)animationQueue {
  if (!_animationQueue) {
    _animationQueue = [[AnimationQueue alloc] init];
  }
  
  return _animationQueue;
}

@end

NS_ASSUME_NONNULL_END
