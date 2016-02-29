// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>

#import "MatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

/// Matching strategy for the set game cards
@interface SetMatchingStrategy : NSObject <MatchingStrategy>

/// matches the card with other cards. returns positive score if there is a match
/// negative otherwise
- (NSInteger)matchCard:(Card *)card withOtherCards:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
