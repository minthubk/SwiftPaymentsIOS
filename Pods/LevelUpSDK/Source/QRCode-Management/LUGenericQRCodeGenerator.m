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

#import <ZXingObjC/ZXingObjCQRCode.h>
#import "LUGenericQRCodeGenerator.h"

const int8_t LUBlackComponents[4] = {0, 0, 0, 255};
const int8_t LULogoBlueComponents[4] = {14, 92, 122, 255};
const int8_t LULogoGreenComponents[4] = {56, 102, 29, 255};
const int8_t LULogoOrangeComponents[4] = {128, 71, 13, 255};
const int8_t LUWhiteComponents[4] = {255, 255, 255, 255};

@implementation LUGenericQRCodeGenerator

#pragma mark - Object Creation Methods

+ (instancetype)sharedGenerator {
  static LUGenericQRCodeGenerator *sharedInstance = nil;

  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    sharedInstance = [[self alloc] init];
  });

  return sharedInstance;
}

- (id)init {
  self = [super init];
  if (!self) return nil;

  _colorizeCodes = YES;
  _outputHeight = 500;
  _outputWidth = 500;

  return self;
}

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromString:(NSString *)string {
  return [[self sharedGenerator] QRCodeFromString:string];
}

#pragma mark - Private Methods

- (CGImageRef)colorizedQRCodeForResult:(ZXBitMatrix *)result {
  ZXIntArray *topLeft = [result topLeftOnBit];

  int x = topLeft.array[0], y = topLeft.array[1];
  int squareLength = 0;
  while ([result getX:x + squareLength y:y]) {
    squareLength++;
  }

  int width = result.width;
  int height = result.height;

  CGRect topLeftSquare = CGRectMake(x, y, squareLength, squareLength);
  CGRect topRightSquare = CGRectMake(width - x - squareLength - 1, y, squareLength, squareLength);
  CGRect bottomLeftSquare = CGRectMake(x, height - y - squareLength - 1, squareLength, squareLength);

  int8_t *bytes = (int8_t *)calloc(width * height * 4, sizeof(int8_t));
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      const int8_t *intensities;

      CGPoint p = CGPointMake(x, y);
      if (![result getX:x y:y]) {
        intensities = LUWhiteComponents;
      } else if (CGRectContainsPoint(topLeftSquare, p)) {
        intensities = LULogoBlueComponents;
      } else if (CGRectContainsPoint(topRightSquare, p)) {
        intensities = LULogoGreenComponents;
      } else if (CGRectContainsPoint(bottomLeftSquare, p)) {
        intensities = LULogoOrangeComponents;
      } else {
        intensities = LUBlackComponents;
      }

      for (int i = 0; i < 4; i++) {
        bytes[y * width * 4 + x * 4 + i] = intensities[i];
      }
    }
  }

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef c = CGBitmapContextCreate(bytes, width, height, 8, 4 * width, colorSpace,
                                         kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
  CFRelease(colorSpace);
  CGImageRef cgimage = CGBitmapContextCreateImage(c);
  CFRelease(c);
  free(bytes);

  return cgimage;
}

- (CGImageRef)imageForResult:(ZXBitMatrix *)result {
  if (self.colorizeCodes) {
    return [self colorizedQRCodeForResult:result];
  } else {
    ZXImage *image = [ZXImage imageWithMatrix:result];
    return CGImageRetain([image cgimage]);
  }
}

- (UIImage *)QRCodeFromString:(NSString *)string {
  ZXQRCodeWriter *writer = [[ZXQRCodeWriter alloc] init];
  ZXBitMatrix *result = [writer encode:string
                                format:kBarcodeFormatQRCode
                                 width:self.outputWidth
                                height:self.outputHeight
                                 error:nil];

  CGImageRef cgimage = [self imageForResult:result];
  UIImage *image = [[UIImage alloc] initWithCGImage:cgimage scale:1.0f orientation:UIImageOrientationDown];
  CGImageRelease(cgimage);
  return image;
}

@end
