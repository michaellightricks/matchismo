// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View that displays the basic shape of rounded card
@interface CardView : UIControl

/// returns scale factor to scale the
/// values according to view size
- (float)cornerScaleFactor;

/// returns corner radius scaled for current view size
- (float)cornerRadius;

/// pops CGContext
- (void)popContext;

/// color to fill the card shape with
@property (nonatomic) UIColor* roundedRectFillColor;

@end

NS_ASSUME_NONNULL_END
