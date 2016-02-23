// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <UIKit/UIKit.h>

#import "SetMatchingGameVC.h"
#import "SetMatchingGame.h"
#import "SetCard.h"

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetMatchingGameVC()
@end

@implementation SetMatchingGameVC

- (NSUInteger)cardsNumber {
  return 12;
}

+ (NSArray *)colorArray {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

-(CardMatchingGame *)createGame:(NSUInteger)cardsCount {
  return [[SetMatchingGame alloc] initWithCardCount:cardsCount];
}

- (NSAttributedString *)getTitleForCard:(Card *)card {
 
  SetCard* myCard = (SetCard *)card;
  NSString* content = [NSString stringWithFormat:@"%lu%d", (unsigned long)myCard.rank, myCard.symbol];

  NSRange range = NSMakeRange(0, [content length]);
  
  NSMutableAttributedString* result = [[NSMutableAttributedString alloc] initWithString:content];
  
  [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
  
  NSArray* colors = [SetMatchingGameVC colorArray];
  
  switch (myCard.shading) {
    case SHADING_OPEN:
      [result addAttribute:NSStrokeWidthAttributeName value:@3 range:range];
      [result addAttribute:NSStrokeColorAttributeName value:colors[myCard.color] range:range];
      break;
    case SHADING_SOLID:
      [result addAttribute:NSForegroundColorAttributeName value:colors[myCard.color] range:range];
      break;
    case SHADING_STRIPED:
      [result addAttribute:NSForegroundColorAttributeName value:[colors[myCard.color] colorWithAlphaComponent:0.5] range:range];
      break;
      
    default:
      break;
  }
  
  [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
  
  return result;
}

- (UIImage *)getImageForCard:(Card *)card {
  return [UIImage imageNamed: card.isChosen ? @"setcardchosen" : @"setcard"];
}

- (CardView *)createCardView:(Card *)card {
  
  SetCard *setCard = (SetCard *)card;
  
  SetCardView *result = [[SetCardView alloc] init];

  result.rank = setCard.rank;
  result.symbol = setCard.symbol;
  result.color = [SetMatchingGameVC colorArray][setCard.color];
  result.shading = setCard.shading;
  
  return result;
}

@end

NS_ASSUME_NONNULL_END
