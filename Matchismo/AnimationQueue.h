// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>

#import "AnimationQueueItem.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that schedules the animations in serial manner
@interface AnimationQueue : NSObject

/// adds animation for scheduling
- (void)addAnimation:(AnimationQueueItem *)item;

/// clear all scheduled animations
- (void)clearAnimations;

@end

NS_ASSUME_NONNULL_END
