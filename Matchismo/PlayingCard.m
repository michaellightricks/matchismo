//
//  PlayingCard.m
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import "PlayingCard.h"
#import "Card.h"

@implementation PlayingCard

@synthesize suite = _suite;

- (Card *) clone {
  PlayingCard* result = [[PlayingCard alloc] initWithOther:self];
  return result;
}

- (instancetype) initWithOther:(PlayingCard *) other {
  self = [super initWithOther:other];
  
  if (self) {
    self.rank = other.rank;
    self.suite = [NSString stringWithString:other.suite];
  }
  
  return self;
}

- (NSString *)suite {
  return (_suite) ? _suite : @"?";
}

- (void) setSuite:(NSString *)suite {
  if ([[PlayingCard validSuits] containsObject:suite]) {
    _suite = suite;
  }
}

- (void) setRank:(NSUInteger)rank {
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

- (NSString *)contents {
  NSArray* ranks = [PlayingCard validRanks];
  return [ranks[self.rank] stringByAppendingString:self.suite];
}

+ (NSArray *)validSuits {
  NSArray *result = @[@"♠️", @"♣️", @"♥️", @"♦️"];
  return result;
}

+ (NSArray *) validRanks {
  NSArray *result = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
  return result;
}

+ (NSUInteger) maxRank {
  return [[self validRanks] count] - 1;
}

@end
