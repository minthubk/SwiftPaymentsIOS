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
 `LUOrderRequestFactory` is used to build requests related to retrieving orders.
 */
@interface LUOrderRequestFactory : NSObject

/**
 Builds a request to retrieve orders that the current user has made at merchants associated with the
 app.

 On success, this request will return an array of `LUOrder` instances. The response will include a
 URL for the next page of results. This URL can be used with `requestForOrdersOnPage:` to retrieve
 the next page of orders.

 @warning This request requires an access token with the `LUPermissionReadUserOrders` permission.
 */
+ (LUAPIRequest *)requestForOrders;

/**
 Builds a request to retrieve the given page of orders.

 On success, this request will return an array of `LUOrder` instances. If this page doesn't include
 any orders, the response will be empty with a status code of 204 (No Content).

 @warning This request requires an access token with the `LUPermissionReadUserOrders` permission.
 @param pageURL The next page of orders to request.
 */
+ (LUAPIRequest *)requestForOrdersOnPage:(NSURL *)pageURL;

/**
 Builds a request to retrieve an order.

 On success, this request will return an `LUOrder` instance.

 @warning This request requires an access token with the `LUPermissionReadUserOrders` permission.
 @param UUID The UUID of the order to retrieve.
 */
+ (LUAPIRequest *)requestForOrderWithUUID:(NSString *)UUID;

@end
