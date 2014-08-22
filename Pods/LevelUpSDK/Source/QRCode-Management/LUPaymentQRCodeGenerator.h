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
#import "LUPaymentToken.h"

/**
 `LUPaymentQRCodeGenerator` is used to build QR codes for users' payment tokens. All LevelUp QR
 codes include a unique identifier for the current user, but may optionally include a tip percentage
 or the ID of a color that the user would like the LevelUp docks to glow.

 ## Glow Colors

 The current table of colors is:

 - 0: #00FF00 "Soothing Green"
 - 1: #BAFF48 "Atomic Lime"
 - 2: #FF0002 "Tango Red"
 - 3: #0030F8 "Galactic Blue"
 - 4: #7800F7 "Purple Haze"
 - 5: #FFFC48 "Yellow Submarine"
 - 6: #00E4FD "Arctic Teal"
 - 7: #FF00C6 "Sick Flamingo"
 - 8: #00FF84 "Mint Julep"
 - 9: #FF721C "Ninja Orange"
 */
@interface LUPaymentQRCodeGenerator : NSObject

/**
 Generates a `UIImage` containing a QR code with a payment token.

 @param paymentToken The payment token to use when generating the QR code.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken;

/**
 Generates a `UIImage` containing a QR code with a payment token and a tip percentage.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipAmount A tip amount in US cents. The largest possible tip that can be encoded is $453.59.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount;

/**
 Generates a `UIImage` containing a QR code with a payment token and a tip percentage.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipAmount A tip amount in US cents. The largest possible tip that can be encoded is $453.59.
 @param glowColorID The ID of a color.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount glowColorID:(NSInteger)glowColorID;

/**
 Generates a `UIImage` containing a QR code with a payment token and a tip percentage.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipPercentage A tip percentage. For example 100% is represented as 100. The largest possible
 percent that can be encoded is 1295%.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage;

/**
 Generates a `UIImage` containing a QR code with a payment token, tip percentage and glow color ID.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipPercentage A tip percentage. For example 100% is represented as 100. The largest possible
 percent that can be encoded is 1295%.
 @param glowColorID The ID of a color.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end
