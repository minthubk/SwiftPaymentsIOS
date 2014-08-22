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

/**
 `LUAccessToken` represents an authentication token that is used for logins. It includes a token and
 the user's ID.
 */
@interface LUAccessToken : LUAPIModel

/**
 A unique access token returned by the server after authentication succeeds. In order for users to
 remain authenticated between application launches, this value should be securely stored. See
 `LUAPIClient` for more information.
 */
@property (nonatomic, copy, readonly) NSString *token;

/**
 The user's ID.
 */
@property (nonatomic, copy, readonly) NSNumber *userID;

- (id)initWithToken:(NSString *)token userID:(NSNumber *)userID;

@end
