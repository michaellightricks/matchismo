// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsGridViewController : UIViewController

- (void)addCardView:(CardView *)cardView;

@property (nonatomic) NSUInteger minCellsNumber;

@end

NS_ASSUME_NONNULL_END
