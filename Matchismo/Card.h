//
//  Card.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object that implements generic game card
@interface Card : NSObject

/// initilize the card by copying data from other one
- (instancetype)initWithOther:(Card *)card;

/// returns deep copy of the card
- (Card *)clone;

/// string contents of the card
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

/// index of the card in the deck
@property (nonatomic) NSUInteger index;

@end

NS_ASSUME_NONNULL_END
