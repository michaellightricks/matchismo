// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^completionBlock) (BOOL finished);
typedef void (^animationBlock) (void);

@protocol AnimationItem <NSObject>

- (void)runWithCompletion:(completionBlock)completion;

@end

@interface AnimationQueueItem : NSObject <AnimationItem>

- (instancetype) initWithDuration:(float)duration
                  beforeAnimation:(animationBlock)beforeAnimation
                        animation:(animationBlock)animation
                       completion:(completionBlock)completion;

@property (nonatomic) float duration;
@property (copy, nonatomic) animationBlock animation;
@property (copy, nonatomic, nullable) animationBlock beforeAnimation;
@property (copy, nonatomic, nullable) completionBlock completion;

@end

@interface AnimationQueueItemSimple : AnimationQueueItem

- (void)runWithCompletion:(completionBlock)completion;

@property (nonatomic) float delay;

@end

@interface AnimationQueueItemTransition : AnimationQueueItem

- (void)runWithCompletion:(completionBlock)completion;

@property (nonatomic) UIView *view;

@end

NS_ASSUME_NONNULL_END
