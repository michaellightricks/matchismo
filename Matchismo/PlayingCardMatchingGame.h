// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that implements the playing card game
@interface PlayingCardMatchingGame : CardMatchingGame

/// Number of cards that match can be performed on
@property (nonatomic) NSUInteger maxMatchCount;

@end

NS_ASSUME_NONNULL_END
