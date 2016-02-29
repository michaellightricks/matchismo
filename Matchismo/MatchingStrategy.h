//
//  MatchingStrategy.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/11/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Protocol that defines the interface of matching check strategy
@protocol MatchingStrategy <NSObject>

/// checks if there is a match between the card and other cards collection
/// card is given as separate parameter since sometimes it is important to know
/// which card was last to be chosen for match check
- (NSInteger)matchCard:(Card *)card withOtherCards:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END
