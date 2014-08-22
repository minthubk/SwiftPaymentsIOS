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
 `LUInterstitialRequestFactory` builds requests to retrieve interstitials.
 */
@interface LUInterstitialRequestFactory : NSObject

/**
 Builds a request for an interstitial for an order with the given UUID.

 If this order does not have an interestitial, this request will fail with the error code
 `LUAPIErrorNotFound`.

 @warning This request requires an access token with either the `LUPermissionCreateOrders` or
 `LUPermissionReadQRCode` permission.
 @param UUID The UUID of an order.
 */
+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID;

/**
 Builds a request to submit feedback from a feedback interstitial.

 If this order does not have an interestitial, this request will fail with the error code
 `LUAPIErrorNotFound`.

 @warning This request requires an access token with either the `LUPermissionCreateOrders` or
 `LUPermissionReadQRCode` permission.
 @param UUID The UUID of an order.
 @param questionText The text of the question given to the user.
 @param rating The user's rating of the order.
 @param comment The user's comment on the order.
 */
+ (LUAPIRequest *)requestToSubmitFeedbackForOrderWithUUID:(NSString *)UUID
                                             questionText:(NSString *)questionText
                                                   rating:(int)rating
                                                  comment:(NSString *)comment;

@end
