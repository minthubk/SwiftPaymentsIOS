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

#import "LUClaim.h"
#import "LUMonetaryValue.h"

@implementation LUClaim

#pragma mark - Creation

- (id)initWithCampaignID:(NSNumber *)campaignID claimID:(NSNumber *)claimID code:(NSString *)code
                   value:(LUMonetaryValue *)value valueRemaining:(LUMonetaryValue *)valueRemaining {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _claimID = claimID;
  _code = code;
  _value = value;
  _valueRemaining = valueRemaining;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUClaim [address=%p, campaignID=%@, code=%@, ID=%@, value=%@, valueRemaining=%@]",
          self, self.campaignID, self.code, self.claimID, self.value, self.valueRemaining];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUClaim [address=%p, campaignID=%@, ID=%@]", self, self.code,
          self.claimID];
}

@end
