// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "CardsGridViewController.h"

#import "AnimationQueue.h"
#import "Grid.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsGridViewController()

@property (strong, nonatomic) NSMutableArray *cardViewsArray;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) CGRect cardViewSourceFrame;
@property (strong, nonatomic) NSMutableSet *animatedViews;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIPinchGestureRecognizer *pinchRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic) BOOL attachStarted;
@property (strong, nonatomic) NSMutableArray *cardGestureRecognizers;

@end

@implementation CardsGridViewController

#define ITEM_MARGIN_SIZE (2)

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addGestureRecognizer:self.pinchRecognizer];
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

  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCard:)];
  [cardView addGestureRecognizer:tapRecognizer];
  [self.cardGestureRecognizers addObject:tapRecognizer];

  [self.view addSubview:cardView];
  
  if (_grid) {
    [self addDealAnimationForCard:[self.cardViewsArray count] - 1];
  }
}

- (void)touchCard:(UITapGestureRecognizer *)recognizer {
  if (self.attachStarted) {
    return;
  }

  CardView *sender = (CardView *)recognizer.view;

  self.onTouchCard(sender);
}

- (CGRect)getFrameForCardIndex:(NSUInteger)index byGrid:(Grid *)grid{
  NSUInteger row = index / self.grid.columnCount;
  NSUInteger colum = index % self.grid.columnCount;
  
  return CGRectInset([grid frameOfCellAtRow:row inColumn:colum], ITEM_MARGIN_SIZE, ITEM_MARGIN_SIZE);
}

- (void)removeCardViews:(NSArray *)indices {
  NSArray *removed = [self removeCardViewsInternal:indices];
  
  [self addRemoveAnimation:removed];
}

- (NSArray *)removeCardViewsInternal:(NSArray *)indices{
  indices = [indices sortedArrayUsingSelector:@selector(compare:)];

  NSMutableArray *removed = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < [indices count]; ++i) {
    NSNumber *index = (NSNumber *)indices[[indices count] - i - 1];
    NSUInteger integerIdx = [index unsignedIntegerValue];
    
    CardView *cardView = self.cardViewsArray[integerIdx];
    
    UITapGestureRecognizer *recognizer = self.cardGestureRecognizers[integerIdx];
    [self.cardGestureRecognizers removeObjectAtIndex:integerIdx];
    [cardView removeGestureRecognizer:recognizer];
    
    [removed addObject:[self.cardViewsArray objectAtIndex:integerIdx]];
    [self.cardViewsArray removeObjectAtIndex:integerIdx];
  }
  
  return removed;
}

- (void)addRemoveAnimation:(NSArray *)cardViews {
  __weak CardsGridViewController *weakSelf = self;
  
  AnimationQueueItemSimple *item = [[AnimationQueueItemSimple alloc] init];
  item.duration = ANIMATION_DURATION_DEFAULT;
  item.delay = 0.5;
  item.animation = ^{
    for (CardView *cardView in cardViews) {
      cardView.frame = CGRectMake(weakSelf.view.bounds.size.width,
                                  weakSelf.view.bounds.size.height, cardView.frame.size.width, cardView.frame.size.height);
    }
  };
  item.beforeAnimation = nil;
  item.completion = ^(BOOL finished) {
    [weakSelf updateIndices];
    
    for (CardView * cardView in cardViews) {
      [cardView removeFromSuperview];
    }
    
    weakSelf.minCellsNumber = [weakSelf.cardViewsArray count];
  };
  
  [self.animationQueue addAnimation:item];
}

- (void)updateViews {
  if (!_grid)
    return;
  
  self.grid.minimumNumberOfCells = self.minCellsNumber;

  if (!self.grid.inputsAreValid) {
    NSLog(@"grid inputs are invalid");
  }
  
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {

    CardView *cardView = self.cardViewsArray[i];
    if ([self.animatedViews containsObject:cardView]) {
      [cardView setFrame:[self getFrameForCardIndex:i byGrid:self.grid]];
    }
  }
  
  [self.view setNeedsDisplay];
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
  item.duration = ANIMATION_DURATION_DEFAULT;
  item.beforeAnimation = ^{[weakSelf.animatedViews addObject:cardView];};

  item.animation = ^{
    cardView.frame = [weakSelf getFrameForCardIndex:index byGrid:self.grid];
  };
  
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
 
  for (CardView *cardView in self.cardViewsArray) {
    [cardView removeFromSuperview];
  }
  
  [self.cardViewsArray removeAllObjects];
}

- (void)updateIndices {
  for (int i = 0; i < [self.cardViewsArray count]; ++i) {
    CardView *cardView = (CardView *)self.cardViewsArray[i];
    cardView.tag = i;
  }
}

- (void)setMinCellsNumber:(NSUInteger)value {
  _minCellsNumber = value;
  
  [self updateViews];
}
  
- (NSMutableSet *)animatedViews {
  if (!_animatedViews) {
    _animatedViews = [[NSMutableSet alloc] init];
  }
  
  return _animatedViews;
}

- (UIDynamicAnimator *)animator {
  if (!_animator) {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  }
  
  return _animator;
}

- (UIPinchGestureRecognizer *)pinchRecognizer {
  if (!_pinchRecognizer) {
    _pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
  }
  
  return _pinchRecognizer;
}

- (NSMutableArray *)cardGestureRecognizers {
  if (_cardGestureRecognizers) {
    _cardGestureRecognizers = [[NSMutableArray alloc] init];
  }
  
  return _cardGestureRecognizers;
}

- (void)onPinch:(UIPinchGestureRecognizer *)recognizer {
  if (recognizer.state != UIGestureRecognizerStateEnded) {
    return;
  }
    
  if (recognizer.scale < 0.5 && !self.attachStarted) {
    CGPoint location = [recognizer locationInView:self.view];
    [self startAttachMode:location];
  }
  else if (recognizer.scale > 0.7 && self.attachStarted) {
    [self stopAttachMode];
  }
}

- (void)onPan:(UIPanGestureRecognizer *)recognizer {
  if (recognizer.state == UIGestureRecognizerStateBegan
      || recognizer.state == UIGestureRecognizerStateChanged) {
    for (UISnapBehavior *snap in self.animator.behaviors) {
      snap.snapPoint = [recognizer locationInView:self.view];
    }
  }
}

- (void)startAttachMode:(CGPoint)location {
  self.attachStarted = YES;

  [self attachViews:self.cardViewsArray toAnchor:location];
  
  self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
  [self.view addGestureRecognizer:self.panRecognizer];
}

- (void)attachViews:(NSArray *)views toAnchor:(CGPoint)anchor {
  for (CardView *cardView in views) {
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView
                                                    snapToPoint:anchor];
    snap.damping = 1;
    [self.animator addBehavior:snap];
  }
}

- (void)stopAttachMode {
  self.attachStarted = NO;

  [self.animator removeAllBehaviors];
  [self.view removeGestureRecognizer:self.panRecognizer];
  
  AnimationQueueItemSimple* animation = [[AnimationQueueItemSimple alloc] init];
  animation.duration = ANIMATION_DURATION_DEFAULT;
  animation.animation = ^{
      for (CardView *cardView in self.cardViewsArray) {
        cardView.frame = [self getFrameForCardIndex:cardView.tag byGrid:self.grid];
      }
    };
  
  [self.animationQueue addAnimation:animation];
}

@end

NS_ASSUME_NONNULL_END
