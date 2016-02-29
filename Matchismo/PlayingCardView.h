// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that displays the playing card
/// Displays the suite and rank at the corners
/// and appropriate image (pips or picture) in the center
@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;

@property (nonatomic) NSString* suite;

@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
