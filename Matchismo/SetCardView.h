// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import "CardView.h"
#import "SetDefinitions.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that displays the set card
@interface SetCardView : CardView

@property (nonatomic) SetCardShading shading;
@property (nonatomic) UIColor* color;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) NSUInteger rank;

@property (nonatomic) BOOL chosen;

@end

NS_ASSUME_NONNULL_END
