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

#import <UIKit/UIKit.h>

/**
 `LUGenericQRCodeGenerator` is used to build generic QR codes from arbitrary strings. Use
 `LUPaymentTokenQRCodeGenerator` to generate user QR codes for payment.
 */
@interface LUGenericQRCodeGenerator : NSObject

/**
 When enabled, QR codes will be colorized to match the LevelUp logo. Defaults to `YES`.
 */
@property (nonatomic, assign) BOOL colorizeCodes;

/**
 The desired output height for QR codes in pixels. Default is 500.
 */
@property (nonatomic, assign) int outputHeight;

/**
 The desired output width for QR codes in pixels. Default is 500.
 */
@property (nonatomic, assign) int outputWidth;

/**
 Returns the `LUGenericQRCodeGenerator` singleton.

 @return The shared `LUGenericQRCodeGenerator` instance.
 */
+ (instancetype)sharedGenerator;

/**
 Generates a `UIImage` containing a QR code.

 @param string A string to be encoded as a QR code.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromString:(NSString *)string;

@end
