//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "MatchingStrategy.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// protected abstract start

- (Deck *)createDeck;
- (id <MatchingStrategy>)createMatchingStrategy;

// protected abstract end

@property (strong, nonatomic) NSString *status;
@property (readonly) BOOL started;
@property (readonly) NSInteger score;

@end
