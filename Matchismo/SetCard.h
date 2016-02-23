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

typedef enum setCardColors {
  COLORS_RED,
  COLORS_GREEN,
  COLORS_PURPLE,
  COLORS_MAX
} SetCardColor;

@interface SetCard : Card

- (instancetype) initWithOther:(SetCard *) other;

+(NSUInteger) maxRank;

@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) NSUInteger rank;

@end
