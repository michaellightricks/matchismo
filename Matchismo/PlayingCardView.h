// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString* suit;
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
