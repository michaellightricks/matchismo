// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^completionBlock) (BOOL finished);
typedef void (^animationBlock) (void);

#define ANIMATION_DURATION_DEFAULT 0.2

/// Abstract class for animation queue item
@interface AnimationQueueItem : NSObject

- (instancetype) initWithDuration:(float)duration
                  beforeAnimation:(animationBlock)beforeAnimation
                        animation:(animationBlock)animation
                       completion:(completionBlock)completion;

/// performs the animation
- (void)runWithCompletion:(completionBlock)completion;

/// duration of animation in seconds
@property (nonatomic) float duration;

/// blocks for animation scheduling steps
@property (copy, nonatomic) animationBlock animation;
@property (copy, nonatomic, nullable) animationBlock beforeAnimation;
@property (copy, nonatomic, nullable) completionBlock completion;

@end

/// Simple animation implementation
@interface AnimationQueueItemSimple : AnimationQueueItem

/// performs the animation
- (void)runWithCompletion:(completionBlock)completion;

/// delay to wait befor animation (in seconds)
@property (nonatomic) float delay;

@end

/// Transition animation implementation
@interface AnimationQueueItemTransition : AnimationQueueItem

/// performs the animation
- (void)runWithCompletion:(completionBlock)completion;

/// view to perform the transition on
@property (nonatomic) UIView *view;

@end

NS_ASSUME_NONNULL_END
