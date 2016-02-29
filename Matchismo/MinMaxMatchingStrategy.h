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

/// Object that implements matching strategy with playing cards
/// when we have maxCardsNumberToMatch chosen match check is performed
/// there is match if we have at least minCardsNumberToMatch of cards that match
@interface MinMaxMatchingStrategy : NSObject <MatchingStrategy>

/// initialize the strategy with min chosen cards and max cards to match
- (instancetype) initWithMin:(NSUInteger)minCardsToMatch max:(NSUInteger) maxCardsToMatch;

/// matches the card with other cards returns positive value if there is a match
/// negative otherwise
- (NSInteger)matchCard:(Card *)card withOtherCards:(NSArray *)cards;

/// minimum cards that have to match in order to give positive score value
@property (nonatomic) NSUInteger minCardsNumberToMatch;

/// number of chosen cards to perform match on
@property (nonatomic) NSUInteger maxCardsNumberToMatch;

@end

NS_ASSUME_NONNULL_END
