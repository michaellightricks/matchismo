//
//  PlayingCard.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

- (instancetype) initWithOther:(PlayingCard *) other;

@property (strong, nonatomic) NSString *suite;
@property (nonatomic) NSUInteger rank;



@end
