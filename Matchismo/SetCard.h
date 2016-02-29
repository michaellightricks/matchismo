//
//  SetCard.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"
#import "SetDefinitions.h"

NS_ASSUME_NONNULL_BEGIN

/// enumeration of valid colors for set card
typedef enum setCardColors {
  COLORS_RED,
  COLORS_GREEN,
  COLORS_PURPLE,
  COLORS_MAX
} SetCardColor;

/// Object that implements the set game card
@interface SetCard : Card

/// initializes the card by copying the properties of the other one
- (instancetype) initWithOther:(SetCard *) other;

/// max valid rank for the set card
+(NSUInteger) maxRank;

@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END