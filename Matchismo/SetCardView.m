// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

#define SYMBOL_SIZE_FACTOR (0.7f)
#define MAX_RANK 3
#define STRIPES_NUMBER 11

- (void)drawRect:(CGRect)rect {
  
  [super drawRect:rect];

  float symbolWidth = [self bounds].size.width * SYMBOL_SIZE_FACTOR;
  float symbolHeight = [self bounds].size.height * SYMBOL_SIZE_FACTOR / MAX_RANK;
  
  float symbolMargin = MAX(symbolHeight / 6, 2);
  
  CGSize size = CGSizeMake(symbolWidth, symbolHeight);
  
  float originX = ([self bounds].size.width - symbolWidth) / 2;
  float originY = ([self bounds].size.height - symbolHeight * self.rank - symbolMargin * (self.rank - 1)) / 2;
  
  for (int i = 0; i < self.rank; ++i) {
    CGPoint origin = CGPointMake(originX, originY + (i * (symbolHeight + symbolMargin)));
    
    [self translateContextAndPush:origin];
    [self drawSingleSymbolBySize:size];
    [self popContext];
  }
}

- (void)translateContextAndPush:(CGPoint)translateToPoint {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);

  CGContextTranslateCTM(context, translateToPoint.x, translateToPoint.y);
}

- (void)drawSingleSymbolBySize:(CGSize)size {

  UIBezierPath* symbolPath = nil;
  CGRect rectAtOrigin = CGRectMake(0, 0, size.width, size.height);
  
  switch (self.symbol) {
    case SYMBOL_DIAMOND:
      symbolPath = [self createDiamondPathBySize:size];
      break;
    case SYMBOL_OVAL:
      symbolPath = [UIBezierPath bezierPathWithRoundedRect:rectAtOrigin cornerRadius:size.width/2];
      break;
    case SYMBOL_SQUIGGLE:
      symbolPath = [self createSquigglePathBySize:size];
      break;
    default:
      assert(0);
  }
  
  switch (self.shading) {
    case SHADING_STRIPED: {
      [symbolPath addClip];
      UIBezierPath *stripesPath = [self createStripesPath:size withCount:STRIPES_NUMBER];
      [self.color setStroke];
      [stripesPath stroke];
    }
    case SHADING_OPEN:
      [self.color setStroke];
      [symbolPath setLineWidth:4.0f];
      [symbolPath stroke];
      break;
    case SHADING_SOLID:
      [self.color setFill];
      [symbolPath fill];
      break;
    default:
      assert(0);
  }
}

- (UIBezierPath *)createDiamondPathBySize:(CGSize)size {
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(0, size.height / 2)];
  [path addLineToPoint:CGPointMake(size.width / 2, 0)];
  [path addLineToPoint:CGPointMake(size.width, size.height / 2)];
  [path addLineToPoint:CGPointMake(size.width / 2, size.height)];
  [path closePath];
  
  return path;
}

- (UIBezierPath *)createSquigglePathBySize:(CGSize)size {
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:CGPointMake(size.width*0.05, size.height*0.40)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.35, size.height*0.25)
          controlPoint1:CGPointMake(size.width*0.09, size.height*0.15)
          controlPoint2:CGPointMake(size.width*0.18, size.height*0.10)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.75, size.height*0.30)
          controlPoint1:CGPointMake(size.width*0.40, size.height*0.30)
          controlPoint2:CGPointMake(size.width*0.60, size.height*0.45)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.97, size.height*0.35)
          controlPoint1:CGPointMake(size.width*0.87, size.height*0.15)
          controlPoint2:CGPointMake(size.width*0.98, size.height*0.00)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.45, size.height*0.85)
          controlPoint1:CGPointMake(size.width*0.95, size.height*1.10)
          controlPoint2:CGPointMake(size.width*0.50, size.height*0.95)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.25, size.height*0.85)
          controlPoint1:CGPointMake(size.width*0.40, size.height*0.80)
          controlPoint2:CGPointMake(size.width*0.35, size.height*0.75)];
  
  [path addCurveToPoint:CGPointMake(size.width*0.05, size.height*0.40)
          controlPoint1:CGPointMake(size.width*0.00, size.height*1.10)
          controlPoint2:CGPointMake(size.width*0.005, size.height*0.60)];
  
  [path closePath];
  
  return path;
}

- (UIBezierPath *)createStripesPath:(CGSize)size withCount:(int)count{

  UIBezierPath *path = [[UIBezierPath alloc] init];

  int stripesCountHalf = count / 2;
  
  float stripeStep = size.width / count;
  
  float middleX = size.width / 2;
  
  [self addStripeToPath:path atX:middleX withHeight:size.height];
  
  for (int i = 0; i < stripesCountHalf; ++i) {
    
    float x = middleX - i * stripeStep;
    [self addStripeToPath:path atX:x withHeight:size.height];

    x = middleX + i * stripeStep;
    [self addStripeToPath:path atX:x withHeight:size.height];
  }
  
  return path;
}

- (void)addStripeToPath:(UIBezierPath *)path atX:(float)x withHeight:(float)height {
  [path moveToPoint:CGPointMake(x, 0)];
  [path addLineToPoint:CGPointMake(x, height)];
}

- (void)setSymbol:(SetCardSymbol)symbol {
  _symbol = symbol;
  
  [self setNeedsDisplay];
}

- (void)setShading:(SetCardShading)shading {
  _shading = shading;
  
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  
  [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
  _color = color;
  
  [self setNeedsDisplay];
}

- (void)setChosen:(BOOL)chosen {
  self.roundedRectFillColor = (chosen) ? [UIColor yellowColor] : [UIColor whiteColor];
  _chosen = chosen;
  [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
