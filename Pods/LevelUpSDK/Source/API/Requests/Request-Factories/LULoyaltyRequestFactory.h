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
 `LULoyaltyRequestFactory` is used to build requests related to loyalty.
 */
@interface LULoyaltyRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's loyalty at a specific merchant.

 When successful, an `LULoyalty` instance will be returned.

 @warning This request requires an access token with the `LUPermissionManageUserCampaigns` permission.
 @param merchantID The ID of the merchant whose loyalty will be requested.
 */
+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID;

@end
