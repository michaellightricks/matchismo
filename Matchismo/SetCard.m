//
//  SetCard.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/15/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@implementation SetCard

+(NSUInteger)maxRank {
  return 3;
}

+(NSArray *)validSymbols {
  return @[@"▲", @"●", @"■"];
}

+(NSArray *)validColors {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

- (NSString*)contents {
  return [NSString stringWithFormat:@"%lu%@%d%@", (unsigned long)self.rank, self.symbol, self.shading, self.color.description];
}

- (instancetype)initWithOther:(SetCard *) other {
  self = [super initWithOther:other];
  
  if (self) {
    self.rank = other.rank;
    self.symbol = other.symbol;
    self.shading = other.shading;
    self.color = other.color;
  }
  
  return self;
}

- (Card *)clone {
  SetCard* result = [[SetCard alloc] initWithOther:self];
  return result;
}

@end
