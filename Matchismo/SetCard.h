//
//  SetCard.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Card.h"


typedef enum setCardShadings
{
  SHADING_SOLID,
  SHADING_STRIPED,
  SHADING_OPEN,
  SHADING_MAX
} SetCardShading;

@interface SetCard : Card

+(NSUInteger) maxRank;
+(NSArray *) validSymbols;
+(NSArray *) validColors;

- (instancetype) initWithOther:(SetCard *) other;

@property (nonatomic) SetCardShading shading;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, strong) NSString* symbol;
@property (nonatomic) NSUInteger rank;

@end
