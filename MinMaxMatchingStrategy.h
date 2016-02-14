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

@property NSUInteger minCardNumberForMatch;
@property NSUInteger maxCardNumberForMatch;

- (NSInteger)matchCard:(Card *) card withOthers:(NSArray *)otherCards;

@end
