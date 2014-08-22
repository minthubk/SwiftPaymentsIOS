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

@class LUAPIRequest;

/**
 `LUClaimRequestFactory` is used to build requests related to claims.
 */
@interface LUClaimRequestFactory : NSObject

/**
 Builds a request to claim a campaign.

 On success, this request will return an instance of `LUClaim`.

 @warning This request requires an access token with the `LUPermissionManageUserCampaigns` permission.
 @param code The code of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimCampaignWithCode:(NSString *)code;

/**
 Builds a request to claim a legacy loyalty campaign.

 On success, this request will return an `LUClaim`.

 @warning This request requires an access token with the `LUPermissionManageUserCampaigns` permission.
 @param legacyID An identifying string. For example, a user's loyalty card number.
 @param campaignID The ID of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID;

@end
