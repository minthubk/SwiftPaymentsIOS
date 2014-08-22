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

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol LUQRCodeScannerViewDelegate;

/**
 `LUQRCodeScannerView` is a utility class to simplify the process of scanning QR codes.

 ## Usage

 Simply add an `LUQRCodeScannerView` to a view, and use the `clearSession`, `startScanning`, and
 `stopScanning` methods to control the scanner. Specify a `LUQRCodeScannerViewDelegate` to be
 notified when a QR code is successfully scanned.
 */
@interface LUQRCodeScannerView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

/**
 The color of the cross hairs on the view. Default is #1EBBF3.
 */
@property (strong) UIColor *crossHairsColor;

/**
 A `LUQRCodeScannerViewDelegate` delegate.
 */
@property (weak) id<LUQRCodeScannerViewDelegate> delegate;

/**
 Clears the current scanning session.
 */
- (void)clearSession;

/**
 Begins scanning.
 */
- (void)startScanning;

/**
 Stops scanning.
 */
- (void)stopScanning;

@end

/**
 The `LUQRCodeScannerViewDelegate` protocol is used to be notified when an `LUQRCodeScannerView`
 successfully scans a QR code.
 */
@protocol LUQRCodeScannerViewDelegate

/**
 Called when a QR code has been scanned.

 @param result The data of the QR code.
*/
- (void)didDecodeQRCodeWithResult:(NSString *)result;

@end
