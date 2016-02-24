// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "AnimationQueueItem.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AnimationQueueItem

- (instancetype) initWithDuration:(float)duration
                  beforeAnimation:(animationBlock)beforeAnimation
                        animation:(animationBlock)animation
                       completion:(completionBlock)completion {
  self = [super init];
  
  if (self) {
    self.duration = duration;
    self.beforeAnimation = beforeAnimation;
    self.animation = animation;
    self.completion = completion;
  }
  
  return self;
}

@end

NS_ASSUME_NONNULL_END
