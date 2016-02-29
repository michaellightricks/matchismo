//
//  PlayingCard.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that implements playing card
@interface PlayingCard : Card

// returns array of valid suits strings
+(NSArray *) validSuits;

// returns maximum valid playing card rank
+(NSUInteger) maxRank;

/// initializes the card by copying the other card properties
- (instancetype) initWithOther:(PlayingCard *) other;

/// cards suite
@property (strong, nonatomic) NSString *suite;

/// cards rank
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END