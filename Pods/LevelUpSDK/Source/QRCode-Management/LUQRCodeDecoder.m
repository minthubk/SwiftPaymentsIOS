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
#import "LUQRCodeDecoder.h"

static NSInteger const kMaxConcurrentCaptureOperations = 2;

@interface LUQRCodeDecoder ()
@property (nonatomic, strong) NSOperationQueue *decodeQueue;
@property (nonatomic, strong) ZXQRCodeReader *reader;
@end

@implementation LUQRCodeDecoder

#pragma mark - Creation/Removal Methods

- (id)init {
  self = [super init];

  if (self) {
    _decodeQueue = [[NSOperationQueue alloc] init];
    _decodeQueue.maxConcurrentOperationCount = kMaxConcurrentCaptureOperations;
    _reader = [[ZXQRCodeReader alloc] init];
  }

  return self;
}

- (void)dealloc {
  [_decodeQueue cancelAllOperations];
}

#pragma mark - Public Methods

- (void)decodeQRCodeFromSampleBuffer:(CMSampleBufferRef)sampleBuffer withCompletionHandler:(LUQRCodeDecoderCompletionHandler)completionHandler {
  if (self.decodeQueue.operationCount < self.decodeQueue.maxConcurrentOperationCount) {
    CGImageRef sourceImage = [self imageFromSampleBuffer:sampleBuffer];
    ZXCGImageLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:sourceImage];
    CGImageRelease(sourceImage);

    [self.decodeQueue addOperationWithBlock:^{
      @autoreleasepool {
        ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource:source];
        ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
        ZXResult *result = [self.reader decode:bitmap hints:nil error:nil];
        completionHandler([result description]);
      }
    }];
  }
}

#pragma mark - Private Methods

- (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
  // Code taken and modified from Apple QA1702.
  // Available at http://developer.apple.com/library/ios/#qa/qa1702/_index.html

  // Create a device-dependent RGB color space
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  // Get a CMSampleBuffer's Core Video image buffer from the media data
  CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);

  // Lock the base address of the pixel buffer
  CVPixelBufferLockBaseAddress(imageBuffer, 0);

  // Create a bitmap graphics context with the sample buffer data
  void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
  size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
  size_t width = CVPixelBufferGetWidth(imageBuffer);
  size_t height = CVPixelBufferGetHeight(imageBuffer);
  CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace,
                                               kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);

  // Create a Quartz image from the pixel data in the bitmap graphics context
  CGImageRef quartzImage = CGBitmapContextCreateImage(context);

  // Unlock the pixel buffer
  CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

  // Free up the context and color space
  CGContextRelease(context);
  CGColorSpaceRelease(colorSpace);

  return quartzImage;
}

@end
