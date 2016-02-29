//
//  Deck.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that implements collection of cards
@interface Deck : NSObject

/// adds card on top of the deck
-(void) addCard:(Card *)card atTop:(BOOL) atTop;

/// adds card at the bottom of the deck
-(void) addCard:(Card *)card;

/// returns random card from the deck
-(Card *) drawRandomCard;

@end

NS_ASSUME_NONNULL_END
