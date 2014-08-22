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
@class LUUser;

/**
 `LUTicketRequestFactory` is used to build requests related to users.
 */
@interface LUUserRequestFactory : NSObject

/**
 Builds a request to return the current user. This is a convenience method to call
 `requestForUserWithID:` with the userID of the cached user object.

 On success, this request will return an `LUUser` instance.
 @warning This request requires an access token with the `LUPermissionReadUserBasicInfo` permission.
 */
+ (LUAPIRequest *)requestForCurrentUser;

/**
 Builds a request to fetch the user with the given user ID.

 On success, this request will return an `LUUser` instance.

 @param userID The ID for the user requested.
 @deprecated This method has been deprecated. Use `requestForCurrentUser` instead.
 */
+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID DEPRECATED_ATTRIBUTE;

/**
 Builds a request to create a user.

 Note that usually you will want to use `requestToCreateUser:withPermissions:` so that you
 can include a list of permissions along with the user information.

 On success, this request will return the newly created `LUUser`.

 @warning Use of this request requires an Enterprise SDK license.
 @param user The `LUUser` to create.
 */
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user;

/**
 Builds a request to create a user along with an array of permissions.

 On success, this request will return an `LUUserWithAccessToken` containing the newly created
 `LUUser` and the `LUAccessToken`.

 @param user The `LUUser` to create.
 @param permissions An array of permission names. For a full list of possible permissions, see
 http://developer.thelevelup.com/getting-started/permissions-list/
 */
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user withPermissions:(NSArray *)permissions;

/**
 Builds a request to reset the password of a user.

 On success, this request will return `nil`.

 @warning Use of this request requires an Enterprise SDK license.
 @param email An email address.
 */
+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email;

/**
 Builds a request to update a user.

 On success, this request will return the updated `LUUser`.

 @warning Use of this request requires an Enterprise SDK license.
 @param user The `LUUser` to update.
 */
+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user;

@end
