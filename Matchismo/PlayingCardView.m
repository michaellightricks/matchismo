// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Michael Kupchick.

#import "PlayingCardView.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardView

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  if (self.faceUp) {
    [self drawCorners];
    [self drawFace];
  }
  else {
    [self drawBack];
  }
}

- (void)drawCorners {
  NSMutableParagraphStyle* pstyle = [[NSMutableParagraphStyle alloc] init];
  pstyle.alignment = NSTextAlignmentCenter;
  
  UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  font = [font fontWithSize:font.pointSize * [self cornerScaleFactor]];
  
  NSDictionary* cornerAttributes = @{
                                     NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:pstyle
                                     };
  
  NSAttributedString* cornerString =
  [[NSAttributedString alloc] initWithString:[self cardString]
                                  attributes:cornerAttributes];
  
  CGRect rectToDrawString = CGRectMake([self cornerOffset],
                                       [self cornerOffset],
                                       [cornerString size].width,
                                       [cornerString size].height);
  
  [cornerString drawInRect:rectToDrawString];
  
  [self pushContextAndRotateUpsideDown];
  
  [cornerString drawInRect:rectToDrawString];
  
  [self popContext];
}

- (void)drawFace {
  NSString* imageString = [NSString stringWithFormat:@"%@%@.jpg", [self rankAsString], self.suite];
  
  UIImage *faceImage = [UIImage imageNamed:imageString];
  
  if (faceImage) {
    [self drawFaceImage:faceImage];
  }
  else {
    [self drawPips];
  }
}

- (void)drawBack {
  UIImage* image = [UIImage imageNamed:@"cardback"];
  
  [image drawInRect:self.bounds];
}

#define FACE_CARD_SCALE_FACTOR 0.2

- (void)drawFaceImage:(UIImage *)image {
  CGRect rect = CGRectInset(self.bounds,
              self.bounds.size.width * FACE_CARD_SCALE_FACTOR,
              self.bounds.size.height * FACE_CARD_SCALE_FACTOR);
  [image drawInRect:rect];
  
}

- (void)pushContextAndRotateUpsideDown
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

#pragma mark - Draw Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips {
  if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:PIP_VOFFSET2_PERCENTAGE
                    mirroredVertically:(self.rank != 7)];
  }
  if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET3_PERCENTAGE
                    mirroredVertically:YES];
  }
  if ((self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET1_PERCENTAGE
                    mirroredVertically:YES];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.20

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown {
  if (upsideDown) [self pushContextAndRotateUpsideDown];
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suite attributes:@{ NSFontAttributeName : pipFont }];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(
                                  middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                  middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                  );
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset*2.0*self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
  if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
  [self drawPipsWithHorizontalOffset:hoffset
                      verticalOffset:voffset
                          upsideDown:NO];
  if (mirroredVertically) {
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:YES];
  }
}

- (float)cornerOffset {
  return [self cornerRadius] / 3;
}

- (NSString *)rankAsString {
  NSArray* ranksArray = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
  
  return ranksArray[self.rank];
}

- (NSString*)cardString {
  return [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suite];
}

- (void)setSuite:(NSString *)suite {
  _suite = suite;
  
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;

  [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
