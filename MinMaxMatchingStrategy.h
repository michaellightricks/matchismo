//
//  TwoMinMatchingStrategy.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchingStrategy.h"

@interface MinMaxMatchingStrategy : NSObject <MatchingStrategy>

@property NSUInteger minCardsNumberToMatch;
@property NSUInteger maxCardsNumberToMatch;

- (instancetype) initWithMin:(NSUInteger) minCardsToMatch max:(NSUInteger) maxCardsToMatch;

- (NSInteger)matchCard:(Card *) card withOthers:(NSArray *)otherCards returnInvolved:(NSMutableArray *) involved;

@end
