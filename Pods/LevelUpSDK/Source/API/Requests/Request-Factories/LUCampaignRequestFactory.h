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
 `LUCampaignRequestFactory` is used to build requests related to campaigns.
 */
@interface LUCampaignRequestFactory : NSObject

/**
 Builds a request to retrieve the merchants associated with the campaign. Only the merchant IDs are
 returned; they are represented as an `NSArray` of `NSNumber` instances. If the campaign is global
 (it applies to all merchants), then this request will return `nil`.

 @param campaignID The ID of the campaign whose merchants will be retrieved.
 */
+ (LUAPIRequest *)requestForMerchantsForCampaignWithID:(NSNumber *)campaignID;

/**
 Builds a request to retrieve a campaign by its code. This is most commonly used when a user has
 scanned a QR code for the campaign. The value retrieved from the QR code can be used with this
 request to retrieve the associated campaign.

 On success, this request will return the requested `LUCampaign` instance.

 @param code The code of the campaign to retrieve.
 */
+ (LUAPIRequest *)requestForCampaignWithCode:(NSString *)code;

/**
 Builds a request to retrieve a campaign by its unique ID.

 On success, this request will return the requested `LUCampaign` instance.

 @param campaignID The ID of the campaign to retrieve.
 */
+ (LUAPIRequest *)requestForCampaignWithID:(NSNumber *)campaignID;

@end
