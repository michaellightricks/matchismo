// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "MatchingStrategy.h"
NS_ASSUME_NONNULL_BEGIN

@interface SetMatchingStrategy : NSObject <MatchingStrategy>

- (NSInteger)matchCards:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END
