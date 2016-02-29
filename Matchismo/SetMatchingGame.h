// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

/// Set matching game implementation
@interface SetMatchingGame : CardMatchingGame

// returns array with new cards
- (NSArray *)addNewSet;

@end

NS_ASSUME_NONNULL_END
