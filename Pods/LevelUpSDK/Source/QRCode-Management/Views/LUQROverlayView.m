/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUQROverlayView.h"

static const CGFloat kXPadding = 0.0f;
static const CGFloat kYPadding = 0.0f;
static const CGFloat kCropHeight = 240.0f;
static const CGFloat kCropWidth = 240.0f;

@interface LUQROverlayView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LUQROverlayView

#pragma mark -
#pragma mark Creation/Removal Methods

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (nil != self) {
    self.backgroundColor = [UIColor clearColor];
    self.crossHairsColor = [UIColor colorWithRed:30.0f/255.0f green:187.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
  }

  return self;
}

#pragma mark -
#pragma mark Properties

- (CGRect)cropRect {
  return CGRectMake((self.frame.size.width - kXPadding - kCropWidth) / 2,
                    (self.frame.size.height - kYPadding - kCropHeight) / 2,
                    kCropWidth,
                    kCropHeight);
}

- (UIImage *)image {
  return self.imageView.image;
}

- (void)setCrossHairsColor:(UIColor *)crossHairsColor {
  _crossHairsColor = crossHairsColor;

  [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image {
  if(self.imageView) {
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.alpha = 0.5;
  } else {
    self.imageView.image = image;
  }

  CGRect frame = self.imageView.frame;
  frame.origin.x = self.cropRect.origin.x;
  frame.origin.y = self.cropRect.origin.y;
  self.imageView.frame = frame;

  self.points = nil;
  self.backgroundColor = [UIColor clearColor];

  [self setNeedsDisplay];
}

- (void)setPoints:(NSArray *)points {
  _points = points;

  if (nil == self.points) {
    self.backgroundColor = [UIColor clearColor];
  } else {
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
  }

  [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Private Methods

- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
  CGFloat lineLength = 34.0f;

  CGContextBeginPath(context);
  CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
  CGContextAddLineToPoint(context, rect.origin.x + lineLength, rect.origin.y);
  CGContextMoveToPoint(context, rect.origin.x + rect.size.width - lineLength, rect.origin.y);
  CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
  CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + lineLength);
  CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - lineLength);
  CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
  CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - lineLength, rect.origin.y + rect.size.height);
  CGContextMoveToPoint(context, rect.origin.x + lineLength, rect.origin.y + rect.size.height);
  CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
  CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - lineLength);
  CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + lineLength);
  CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y - 1.5f);
  CGContextStrokePath(context);
}

#pragma mark -
#pragma mark UIViewController Methods

- (void)drawRect:(CGRect)rect {
  CGContextRef c = UIGraphicsGetCurrentContext();
  CGRect cropRect = [self cropRect];

  if (nil != self.points) {
    [self.imageView.image drawAtPoint:cropRect.origin];
  }

  CGContextSetFillColorWithColor(c, [UIColor colorWithWhite:0.0f alpha:0.2f].CGColor);
  CGContextFillRect(c, rect);
  CGContextClearRect(c, CGRectInset(cropRect, -1.5f, -1.5f));

  CGContextSetStrokeColorWithColor(c, self.crossHairsColor.CGColor);
  CGContextSetLineWidth(c, 3);
  [self drawRect:cropRect inContext:c];

  CGFloat blue[4] = { 0, 1, 0, 1};
  CGContextSetStrokeColor(c, blue);
  CGContextSetLineWidth(c, 2);
  CGRect smallSquare = CGRectMake(0, 0, 10, 10);

  if (nil != self.points) {
    for(NSValue *value in self.points) {
      CGPoint point = [value CGPointValue];
      smallSquare.origin = CGPointMake(cropRect.origin.x + point.x - self.frame.origin.x - 10 - smallSquare.size.width / 2,
                                       cropRect.origin.y + point.y - self.frame.origin.y - 65 - (smallSquare.size.height / 2));
      [self drawRect:smallSquare inContext:c];
    }
  }
}

@end
