// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "AnimationQueue.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationQueue()

@property (strong, nonatomic) NSMutableArray *queue;

@end

@implementation AnimationQueue

- (NSMutableArray *)queue {
  if (!_queue) {
    _queue = [[NSMutableArray alloc] init];
  }
  
  return _queue;
}

- (void)addAnimation:(AnimationQueueItem *)item {
  [self.queue addObject:item];

  if ([self.queue count] == 1) {
    [self runAnimationItem:item];
  }
}

- (void)runAnimationItem:(AnimationQueueItem *)item {
  __weak AnimationQueue* weakSelf = self;
  
  [item runWithCompletion:^(BOOL finished) {
    if ([weakSelf.queue containsObject:item]) {
      [weakSelf.queue removeObject:item];
      
      if ([weakSelf.queue count] > 0) {
        AnimationQueueItem *nextItem = weakSelf.queue[0];
        [weakSelf runAnimationItem:nextItem];
      }
    }
  }];
  
}

- (void)clearAnimations {
  [self.queue removeAllObjects];
}

@end

NS_ASSUME_NONNULL_END
