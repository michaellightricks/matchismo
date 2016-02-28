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

- (CGRect)getFrameForCardIndex:(NSUInteger)index byGrid:(Grid *)grid{
  NSUInteger row = index / self.grid.columnCount;
  NSUInteger colum = index % self.grid.columnCount;
  
  return CGRectInset([grid frameOfCellAtRow:row inColumn:colum], ITEM_MARGIN_SIZE, ITEM_MARGIN_SIZE);
}

- (void)removeCardViews:(NSArray *)indices {

  indices = [indices sortedArrayUsingSelector:@selector(compare:)];

  NSMutableArray *removed = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < [indices count]; ++i) {
    NSNumber *index = (NSNumber *)indices[[indices count] - i - 1];
    NSUInteger integerIdx = [index unsignedIntegerValue];
    [removed addObject:[self.cardViewsArray objectAtIndex:integerIdx]];
    [self.cardViewsArray removeObjectAtIndex:integerIdx];
  }
  
  [self addRemoveAnimation:removed];
}

- (void)addRemoveAnimation:(NSArray *)cardViews {

  __weak CardsGridViewController *weakSelf = self;
  
  AnimationQueueItemSimple *item = [[AnimationQueueItemSimple alloc] init];
  
  item.duration = 0.2;
  item.delay = 1.0;
  item.animation = ^{
    for (CardView *cardView in cardViews) {
      cardView.frame = CGRectInset(cardView.frame, cardView.frame.size.width / 2 - 1, cardView.frame.size.height / 2 - 1);
    }
  };
  item.beforeAnimation = nil;
  item.completion = ^(BOOL finished) {
    [weakSelf updateIndices];
    
    for (CardView * cardView in cardViews) {
      [cardView removeFromSuperview];
    }
  };
  
  [self.animationQueue addAnimation:item];
}

- (void)updateViews {
  if (!_grid)
    return;
  
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {

    CardView *cardView = self.cardViewsArray[i];
    if ([self.animatedViews containsObject:cardView]) {
      [cardView setFrame:[self getFrameForCardIndex:i byGrid:self.grid]];
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
  [self clearAnimations];
  
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {
    [self addDealAnimationForCard:i];
  }
}

- (void)addDealAnimationForCard:(NSUInteger)index {

  __weak CardsGridViewController *weakSelf = self;
  
  CardView *cardView = self.cardViewsArray[index];
  [cardView setFrame:self.cardViewSourceFrame];
  
  AnimationQueueItemSimple *item = [[AnimationQueueItemSimple alloc] init];
  item.duration = 0.2;
  item.beforeAnimation = ^{[weakSelf.animatedViews addObject:cardView];};

  CGRect frame = [weakSelf getFrameForCardIndex:index byGrid:self.grid];
  item.animation = ^{cardView.frame = frame;};
  
  item.completion = nil;

  [self.animationQueue addAnimation:item];
}

- (CardView *)getCardViewAt:(NSUInteger)index {
  return (CardView *)self.cardViewsArray[index];
}

- (void)clearAnimations {
  [self.animationQueue clearAnimations];
  [self.animatedViews removeAllObjects];
}

- (void)clear {
  [self clearAnimations];
 
  while ([self.cardViewsArray count] > 0) {
    NSNumber *index = [[NSNumber alloc] initWithUnsignedLong:[self.cardViewsArray count] - 1];
    [self removeCardViews:@[index]];
  }
}

- (void)updateIndices {
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {
    CardView *cardView = (CardView *)self.cardViewsArray[i];
    cardView.tag = i;
  }
}

@end

NS_ASSUME_NONNULL_END
