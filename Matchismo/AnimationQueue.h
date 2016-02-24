// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "AnimationQueueItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface AnimationQueue : NSObject

- (void)addAnimation:(AnimationQueueItem *)item;
- (void)clearAnimations;

@end

NS_ASSUME_NONNULL_END
