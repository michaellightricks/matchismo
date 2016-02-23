// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView

- (float)cornerScaleFactor;
- (float)cornerRadius;
- (void)popContext;

@end

NS_ASSUME_NONNULL_END
