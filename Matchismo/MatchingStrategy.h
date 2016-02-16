//
//  MatchingStrategy.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@protocol MatchingStrategy <NSObject>

- (NSInteger)matchCards:(NSArray *)cards;

@end