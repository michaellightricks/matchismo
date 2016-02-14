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

- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *) deck
                  andMatchStrategy:(id <MatchingStrategy>) strategy;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (strong, nonatomic) NSString *status;
@property (readonly) BOOL started;
@property (readonly) NSInteger score;
@property NSUInteger maxMatchCount;

@end
