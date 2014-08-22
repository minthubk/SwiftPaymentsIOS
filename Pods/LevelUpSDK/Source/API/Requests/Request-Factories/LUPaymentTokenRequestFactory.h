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
 `LUPaymentTokenRequestFactory` is used to build the request to retrieve a user's payment token.
 */
@interface LUPaymentTokenRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's payment token.

 The user may not be payment eligible. This could happen if they haven't added any credit cards, or
 if their credit card has expired. When that happens, this request will fail with the error code
 `LUAPIErrorNotFound`.

 @warning This request requires an access token with the `LUPermissionReadQRCode` permission.
 */
+ (LUAPIRequest *)requestForPaymentToken;

@end
