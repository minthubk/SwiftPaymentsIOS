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

#import "LUGenericQRCodeGenerator.h"
#import "LUPaymentQRCodeGenerator.h"
#import "LUPaymentStringGenerator.h"

@implementation LUPaymentQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:0 glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount glowColorID:(NSInteger)glowColorID {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:glowColorID];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:tipPercentage glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:tipPercentage glowColorID:glowColorID];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

@end
