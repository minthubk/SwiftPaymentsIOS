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
 `LURegistrationRequestFactory` is used to build the request to check on a user's registration status.
 */
@interface LURegistrationRequestFactory : NSObject

/**
 Builds a request which given an email address, checks if a corresponding LevelUp user exists.

 On success, this request will return an `LURegistration` instance.

 @param email The email address to check.
 */
+ (LUAPIRequest *)requestForRegistrationWithEmail:(NSString *)email;

@end
