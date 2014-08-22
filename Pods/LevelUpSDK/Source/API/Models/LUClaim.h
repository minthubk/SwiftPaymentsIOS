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

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 When a user claims a campaign, an `LUClaim` object is created and returned.
 */
@interface LUClaim : LUAPIModel

/**
 The ID of the campaign that was claimed.
 */
@property (nonatomic, copy, readonly) NSNumber *campaignID;

/**
 The unique identifier for this claim.
 */
@property (nonatomic, copy, readonly) NSNumber *claimID;

/**
 The code of the campaign that was claimed.
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 The full value of the claim.
*/
@property (nonatomic, strong, readonly) LUMonetaryValue *value;

/**
 The value remaining on the claim. As the user spends money, this amount will go down, and will be
 zero once they've used up the full value of the claim.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *valueRemaining;

- (id)initWithCampaignID:(NSNumber *)campaignID claimID:(NSNumber *)claimID code:(NSString *)code
                   value:(LUMonetaryValue *)value valueRemaining:(LUMonetaryValue *)valueRemaining;

@end
