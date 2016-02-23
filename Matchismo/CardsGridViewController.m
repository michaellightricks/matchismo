// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "CardsGridViewController.h"

#import "PlayingCardView.h"
#import "Grid.h"


NS_ASSUME_NONNULL_BEGIN

@interface CardsGridViewController()

@property (nonatomic) NSMutableArray *cardViewsArray;

@property (nonatomic) Grid *grid;

@end

@implementation CardsGridViewController

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
  [self updateViews];
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
    int row = i / self.grid.columnCount;
    int colum = i % self.grid.columnCount;
    
    CardView *cardView = self.cardViewsArray[i];
    CGRect cardViewFrame = CGRectInset([self.grid frameOfCellAtRow:row inColumn:colum], 2, 2);
    [cardView setFrame:cardViewFrame];
    [cardView setNeedsDisplay];
  }
}

- (NSMutableArray *)cardViewsArray {
  if (!_cardViewsArray) {
    _cardViewsArray = [[NSMutableArray alloc] init];
  }
  
  return _cardViewsArray;
}

@end

NS_ASSUME_NONNULL_END
