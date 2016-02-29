// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "AnimationQueueItem.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AnimationQueueItem

- (instancetype)initWithDuration:(float)duration
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

- (void)runWithCompletion:(completionBlock)completion {
  if (self.beforeAnimation) {
    self.beforeAnimation();
  }
}

@end


@implementation AnimationQueueItemSimple

- (void)runWithCompletion:(completionBlock)completion {
  [super runWithCompletion:completion];
  
  [UIView animateWithDuration:self.duration
                        delay:self.delay
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:self.animation
                   completion:^(BOOL finished) {
                     if (self.completion != nil) {
                       self.completion(finished);
                     }
                     
                     if (completion) {
                       completion(finished);
                     }
                   }];

}

@end

@implementation AnimationQueueItemTransition

- (void)runWithCompletion:(completionBlock)completion {
  [super runWithCompletion:completion];
  
  [UIView transitionWithView:self.view
                    duration:self.duration
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:self.animation
                   completion:^(BOOL finished) {
                     if (self.completion != nil) {
                       self.completion(finished);
                     }
                     
                     if (completion) {
                       completion(finished);
                     }
                   }];

}

@end


NS_ASSUME_NONNULL_END
