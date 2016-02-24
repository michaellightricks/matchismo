// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^completionBlock) (BOOL finished);
typedef void (^animationBlock) (void);

@interface AnimationQueueItem : NSObject

- (instancetype) initWithDuration:(float)duration
                  beforeAnimation:(animationBlock)beforeAnimation
                        animation:(animationBlock)animation
                       completion:(completionBlock)completion;

@property (nonatomic) float duration;
@property (copy, nonatomic) animationBlock animation;
@property (copy, nonatomic, nullable) animationBlock beforeAnimation;
@property (copy, nonatomic, nullable) completionBlock completion;

@end

NS_ASSUME_NONNULL_END
