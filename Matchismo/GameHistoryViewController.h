// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MatchingGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that manages the display of game history
/// as a collection of game turns
@interface GameHistoryViewController : UIViewController 

/// Collection of game turns to display as history
@property (weak, nonatomic, nullable) NSArray* turns;

/// Object that provides the status of the turn
@property (weak, nonatomic, nullable) id <TurnStatusProvider> turnStatusProvider;

@end

NS_ASSUME_NONNULL_END
