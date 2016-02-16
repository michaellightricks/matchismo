//
//  ViewController.h
//  Matchismo
//
//  Created by Michael Kupchick on 2/9/16.
//  Copyright © 2016 Michael Kupchick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface MatchingGameViewController : UIViewController

-(CardMatchingGame *)createGame:(NSUInteger)cardsCount;
- (void)updateUI;
- (NSString *)getTitleForCard:(Card *)card;

@property (strong, nonatomic) CardMatchingGame* game;

@end

