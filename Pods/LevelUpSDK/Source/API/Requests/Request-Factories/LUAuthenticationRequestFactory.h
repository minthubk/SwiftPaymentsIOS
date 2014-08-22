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
 `LUAuthenticationRequestFactory` is used to build requests to authenticate with the API.
 */
@interface LUAuthenticationRequestFactory : NSObject

/**
 Builds a request to login via an email and password.

 On success, this request will return an `LUAccessToken` instance.

 @warning Use of this request requires an Enterprise SDK license.
 @param email The email address to use for the login.
 @param password The password to use for the login.
 */
+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password;

/**
 Builds a request to create a new access token with a limited set of permissions.

 On success, a new `LUAccessToken` instance will be returned.

 If the access token used for the request doesn't have access to any of the permissions, the request
 will fail with an `LUAPIErrorLoginRequired` error.

 @warning This request requires an access token with all the downgraded permissions.
 @param permissions An array of permission names. For a full list of possible permissions, see
 http://developer.thelevelup.com/getting-started/permissions-list/
 */
+ (LUAPIRequest *)requestToCreateDowngradedAccessTokenWithPermissions:(NSArray *)permissions;

@end
