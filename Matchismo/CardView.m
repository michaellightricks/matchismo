// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

#define CORNER_HEIGHT (180.0)
#define CORNER_RADIUS (12.0)

@implementation CardView

- (float)cornerScaleFactor {
  return self.bounds.size.height / CORNER_HEIGHT;
}

- (float)cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  
  UIRectFill(self.bounds);
}

- (void)setup {

  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
 
}

- (void)awakeFromNib {
  [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self) {
    [self setup];
  }
  
  return self;
}

- (void)popContext
{
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

@end

NS_ASSUME_NONNULL_END
