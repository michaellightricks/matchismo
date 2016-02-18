//
//  TwoMinMatchingStrategy.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface MinMaxMatchingStrategy : NSObject <MatchingStrategy>

- (instancetype) initWithMin:(NSUInteger) minCardsToMatch max:(NSUInteger) maxCardsToMatch;

- (NSInteger)matchCard:(Card *)card withOtherCards:(NSArray *)cards;

@property (nonatomic) NSUInteger minCardsNumberToMatch;
@property (nonatomic) NSUInteger maxCardsNumberToMatch;

@end

NS_ASSUME_NONNULL_END
