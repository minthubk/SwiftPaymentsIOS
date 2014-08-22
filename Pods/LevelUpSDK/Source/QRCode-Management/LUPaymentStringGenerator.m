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

#import "LUMonetaryValue.h"
#import "LUPaymentStringGenerator.h"
#import "NSNumber+Base36.h"

static NSString * const LUCurrentQRCodeVersion = @"03";
static NSString * const LUQRCodeSentinel = @"LU";
NSUInteger const LUGlowColorLength = 1;
NSUInteger const LUHighestGlowColorID = 35; // Z in base 36
NSUInteger const LUMaximumTipPercentage = 1295; // ZZ in base 36
NSUInteger const LUTipAmountOffset = LUMaximumTipPercentage + 1;
NSUInteger const LUTipLength = 3;
NSUInteger const LUMaximumTipNumber = 46655; // ZZZ in base 36

@interface LUPaymentStringGenerator ()

@property (nonatomic, assign, readonly) NSUInteger glowColorID;
@property (nonatomic, copy, readonly) NSString *paymentToken;
@property (nonatomic, assign, readonly) NSUInteger tipNumber;

@end

@implementation LUPaymentStringGenerator

#pragma mark - Public Methods

+ (NSString *)paymentStringWithToken:(NSString *)token tipAmountInUSCents:(NSInteger)tipAmount glowColorID:(NSInteger)glowColorID {
  NSInteger tipNumber = MIN(tipAmount + LUTipAmountOffset, LUMaximumTipNumber);

  return [[[self alloc] initWithPaymentToken:token tipNumber:tipNumber glowColorID:glowColorID] formattedQRCodeString];
}

+ (NSString *)paymentStringWithToken:(NSString *)token tipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  NSInteger tipNumber = MIN(tipPercentage, LUMaximumTipPercentage);

  return [[[self alloc] initWithPaymentToken:token tipNumber:tipNumber glowColorID:glowColorID] formattedQRCodeString];
}

#pragma mark - Private Methods

- (id)initWithPaymentToken:(NSString *)paymentToken tipNumber:(NSInteger)tipNumber glowColorID:(NSInteger)glowColorID {
  self = [super init];
  if (!self) return nil;

  _paymentToken = paymentToken;
  _glowColorID = glowColorID;
  _tipNumber = tipNumber;

  return self;
}

- (NSString *)formattedQRCodeString {
  NSArray *components = @[
    self.paymentToken,
    LUCurrentQRCodeVersion,
    [self tipBase36],
    [self glowColorIDBase36],
    LUQRCodeSentinel
  ];

  return [components componentsJoinedByString:@""];
}

- (NSString *)glowColorIDBase36 {
  return [[NSNumber numberWithUnsignedInteger:MIN(self.glowColorID, LUHighestGlowColorID)] lu_base36Value];
}

- (NSString *)tipBase36 {
  NSString *tipBase36 = [[NSNumber numberWithInteger:self.tipNumber] lu_base36Value];

  if ([tipBase36 length] > LUTipLength) {
    tipBase36 = [tipBase36 substringFromIndex:[tipBase36 length] - LUTipLength];
  }

  while ([tipBase36 length] < LUTipLength) {
    tipBase36 = [@"0" stringByAppendingString:tipBase36];
  }

  return tipBase36;
}

@end
