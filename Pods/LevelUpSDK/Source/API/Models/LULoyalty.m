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

#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Creation

- (id)initWithMerchantID:(NSNumber *)merchantID merchantLoyaltyEnabled:(BOOL)merchantLoyaltyEnabled
             ordersCount:(NSNumber *)ordersCount potentialCredit:(LUMonetaryValue *)potentialCredit
         progressPercent:(float)progressPercent savings:(LUMonetaryValue *)savings
             shouldSpend:(LUMonetaryValue *)shouldSpend spendRemaining:(LUMonetaryValue *)spendRemaining
             totalVolume:(LUMonetaryValue *)totalVolume willEarn:(LUMonetaryValue *)willEarn {
  self = [super init];
  if (!self) return nil;

  _merchantID = merchantID;
  _merchantLoyaltyEnabled = merchantLoyaltyEnabled;
  _ordersCount = ordersCount;
  _potentialCredit = potentialCredit;
  _progressPercent = progressPercent;
  _savings = savings;
  _shouldSpend = shouldSpend;
  _spendRemaining = spendRemaining;
  _totalVolume = totalVolume;
  _willEarn = willEarn;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LULoyalty [address=%p, merchantID=%@, merchantLoyaltyEnabled=%@, ordersCount=%@, potentialCredit=%@, progressPercent=%@, savings=%@, shouldSpend=%@, spendRemaining=%@, totalVolume=%@, willEarn=%@]",
          self, self.merchantID, @(self.merchantLoyaltyEnabled), self.ordersCount, self.potentialCredit,
          @(self.progressPercent), self.savings, self.shouldSpend, self.spendRemaining, self.totalVolume, self.willEarn];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULoyalty [address=%p, merchantID=%@]", self, self.merchantID];
}

@end
