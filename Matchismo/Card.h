//
//  Card.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) NSString* contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (Card *) clone;

- (instancetype) initWithOther:(Card *) card;

- (int)match:(NSArray *)otherCards;

@end
