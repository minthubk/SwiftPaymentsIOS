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
 `LULocationCreditRequestFactory` is used to request available credit at a location.
 */
@interface LULocationCreditRequestFactory : NSObject

/**
 Builds a request to retrieve available credit at a location. If the requesting user is
 authenticated, it will return the available credit for that user. If there is not an authenticated
 user, then the result will be the available credit
 for a brand new user.

 On success, this request will return an `LUMonetaryValue` containing the available credit amount.

 @warning If an access token is present, it must have the `LUPermissionManageUserCampaigns` permission.
 @param locationID The ID of the location.
 */
+ (LUAPIRequest *)requestForCreditAtLocationID:(NSNumber *)locationID;

@end
