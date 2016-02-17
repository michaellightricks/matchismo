// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MatchingGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameHistoryViewController : UIViewController 

@property (weak, nonatomic, nullable) NSArray* turns;
@property (weak, nonatomic, nullable) id <TurnTitleProvider> turnTitleProvider;

@end

NS_ASSUME_NONNULL_END
