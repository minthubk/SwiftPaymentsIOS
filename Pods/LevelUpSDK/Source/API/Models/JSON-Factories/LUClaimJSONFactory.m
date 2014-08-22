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
#import "LUClaimJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUClaimJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes lu_numberForKey:@"campaign_id"];
  NSNumber *claimID = [attributes lu_numberForKey:@"id"];
  NSString *code = [attributes lu_stringForKey:@"code"];
  LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_amount"]];
  LUMonetaryValue *valueRemaining = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_remaining_amount"]];

  return [[LUClaim alloc] initWithCampaignID:campaignID claimID:claimID code:code value:value
                              valueRemaining:valueRemaining];
}

- (NSString *)rootKey {
  return @"claim";
}

@end
