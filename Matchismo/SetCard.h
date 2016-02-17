//
//  SetCard.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


typedef enum setCardShadings {
  SHADING_SOLID,
  SHADING_STRIPED,
  SHADING_OPEN,
  SHADING_MAX
} SetCardShading;

typedef enum setCardColors {
  COLORS_RED,
  COLORS_GREEN,
  COLORS_PURPLE,
  COLORS_MAX
} SetCardColor;

@interface SetCard : Card

- (instancetype) initWithOther:(SetCard *) other;

+(NSUInteger) maxRank;
+(NSArray *) validSymbols;

@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (strong, nonatomic) NSString* symbol;
@property (nonatomic) NSUInteger rank;

@end
