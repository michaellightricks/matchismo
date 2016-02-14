//
//  Deck.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/10/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL) atTop;
-(void) addCard:(Card *)card;

-(Card *) drawRandomCard;

@end
